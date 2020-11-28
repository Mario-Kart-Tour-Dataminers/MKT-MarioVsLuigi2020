//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/Lut2DBaker" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 31679
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
    float4 _Lut2D_Params;
    float3 _ColorBalance;
    float3 _ColorFilter;
    float3 _HueSatCon;
    float _Brightness;
    float3 _ChannelMixerRed;
    float3 _ChannelMixerGreen;
    float3 _ChannelMixerBlue;
    float3 _Lift;
    float3 _InvGamma;
    float3 _Gain;
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
    sampler sampler_Curves [[ sampler (0) ]],
    texture2d<half, access::sample > _Curves [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    half u_xlat16_1;
    float4 u_xlat2;
    float3 u_xlat3;
    float2 u_xlat4;
    bool u_xlatb4;
    float3 u_xlat5;
    float2 u_xlat10;
    float2 u_xlat11;
    float u_xlat12;
    bool u_xlatb12;
    u_xlat0.yz = input.TEXCOORD1.xy + (-FGlobals._Lut2D_Params.yz);
    u_xlat1.x = u_xlat0.y * FGlobals._Lut2D_Params.x;
    u_xlat0.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat0.x / FGlobals._Lut2D_Params.x;
    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xzw * FGlobals._Lut2D_Params.www;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(FGlobals._Brightness), float3(-0.217637643, -0.217637643, -0.217637643));
    u_xlat0.xyz = fma(u_xlat0.xyz, FGlobals._HueSatCon.xyzx.zzz, float3(0.217637643, 0.217637643, 0.217637643));
    u_xlat1.x = dot(float3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
    u_xlat1.y = dot(float3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
    u_xlat1.z = dot(float3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorBalance.xyzx.xyz;
    u_xlat1.x = dot(float3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
    u_xlat1.y = dot(float3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
    u_xlat1.z = dot(float3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorFilter.xyzx.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, FGlobals._ChannelMixerRed.xyzx.xyz);
    u_xlat1.y = dot(u_xlat0.xyz, FGlobals._ChannelMixerGreen.xyzx.xyz);
    u_xlat1.z = dot(u_xlat0.xyz, FGlobals._ChannelMixerBlue.xyzx.xyz);
    u_xlat0.xyz = fma(u_xlat1.xyz, FGlobals._Gain.xyzx.xyz, FGlobals._Lift.xyzx.xyz);
    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38), float3(0.5, 0.5, 0.5));
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(2.0, 2.0, 2.0), float3(-1.0, -1.0, -1.0));
    u_xlat1.xyz = u_xlat1.xyz * FGlobals._InvGamma.xyzx.xyz;
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlatb12 = u_xlat0.y>=u_xlat0.z;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat1.xy = u_xlat0.zy;
    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
    u_xlat1.z = float(-1.0);
    u_xlat1.w = float(0.666666687);
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(-1.0);
    u_xlat1 = fma(float4(u_xlat12), u_xlat2.xywz, u_xlat1.xywz);
    u_xlatb12 = u_xlat0.x>=u_xlat1.x;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat2.z = u_xlat1.w;
    u_xlat1.w = u_xlat0.x;
    u_xlat3.x = dot(u_xlat0.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat2.xyw = u_xlat1.wyx;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = fma(float4(u_xlat12), u_xlat2, u_xlat1);
    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
    u_xlat5.x = fma(u_xlat1.x, 6.0, 9.99999975e-05);
    u_xlat4.x = (-u_xlat0.y) + u_xlat0.w;
    u_xlat4.x = u_xlat4.x / u_xlat5.x;
    u_xlat4.x = u_xlat4.x + u_xlat0.z;
    u_xlat2.x = abs(u_xlat4.x);
    u_xlat11.x = u_xlat2.x + FGlobals._HueSatCon.xyzx.x;
    u_xlat3.y = float(0.25);
    u_xlat11.y = float(0.25);
    u_xlat4.x = float(_Curves.sample(sampler_Curves, u_xlat11.xy, level(0.0)).x);
    u_xlat4.y = float(_Curves.sample(sampler_Curves, u_xlat3.xy, level(0.0)).w);
    u_xlat4.xy = u_xlat4.xy;
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
    u_xlat4.x = u_xlat11.x + u_xlat4.x;
    u_xlat5.xyz = u_xlat4.xxx + float3(-0.5, 0.5, -1.5);
    u_xlatb4 = 1.0<u_xlat5.x;
    u_xlat4.x = (u_xlatb4) ? u_xlat5.z : u_xlat5.x;
    u_xlatb12 = u_xlat5.x<0.0;
    u_xlat4.x = (u_xlatb12) ? u_xlat5.y : u_xlat4.x;
    u_xlat5.xyz = u_xlat4.xxx + float3(1.0, 0.666666687, 0.333333343);
    u_xlat5.xyz = fract(u_xlat5.xyz);
    u_xlat5.xyz = fma(u_xlat5.xyz, float3(6.0, 6.0, 6.0), float3(-3.0, -3.0, -3.0));
    u_xlat5.xyz = abs(u_xlat5.xyz) + float3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0f, 1.0f);
    u_xlat5.xyz = u_xlat5.xyz + float3(-1.0, -1.0, -1.0);
    u_xlat4.x = u_xlat0.x + 9.99999975e-05;
    u_xlat10.x = u_xlat1.x / u_xlat4.x;
    u_xlat1.xyz = fma(u_xlat10.xxx, u_xlat5.xyz, float3(1.0, 1.0, 1.0));
    u_xlat3.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat1.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, (-u_xlat4.xxx));
    u_xlat2.y = float(0.25);
    u_xlat10.y = float(0.25);
    u_xlat0.x = float(_Curves.sample(sampler_Curves, u_xlat2.xy, level(0.0)).y);
    u_xlat0.w = float(_Curves.sample(sampler_Curves, u_xlat10.xy, level(0.0)).z);
    u_xlat0.xw = u_xlat0.xw;
    u_xlat0.xw = clamp(u_xlat0.xw, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = dot(u_xlat0.ww, u_xlat0.xx);
    u_xlat0.x = u_xlat0.x * u_xlat4.y;
    u_xlat0.x = dot(FGlobals._HueSatCon.xyzx.yy, u_xlat0.xx);
    u_xlat0.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, u_xlat4.xxx);
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz + float3(0.00390625, 0.00390625, 0.00390625);
    u_xlat0.w = 0.75;
    u_xlat16_1 = _Curves.sample(sampler_Curves, u_xlat0.xw).w;
    u_xlat1.x = float(u_xlat16_1);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat5.x = float(_Curves.sample(sampler_Curves, u_xlat0.yw).w);
    u_xlat5.y = float(_Curves.sample(sampler_Curves, u_xlat0.zw).w);
    u_xlat1.yz = u_xlat5.xy;
    u_xlat1.yz = clamp(u_xlat1.yz, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat1.xyz + float3(0.00390625, 0.00390625, 0.00390625);
    u_xlat0.w = 0.75;
    u_xlat16_0 = _Curves.sample(sampler_Curves, u_xlat0.xw).x;
    output.SV_Target0.x = float(u_xlat16_0);
    output.SV_Target0.x = clamp(output.SV_Target0.x, 0.0f, 1.0f);
    u_xlat0.x = float(_Curves.sample(sampler_Curves, u_xlat0.yw).y);
    u_xlat0.y = float(_Curves.sample(sampler_Curves, u_xlat0.zw).z);
    output.SV_Target0.yz = u_xlat0.xy;
    output.SV_Target0.yz = clamp(output.SV_Target0.yz, 0.0f, 1.0f);
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
    float4 _Lut2D_Params;
    float3 _ColorBalance;
    float3 _ColorFilter;
    float3 _HueSatCon;
    float _Brightness;
    float3 _ChannelMixerRed;
    float3 _ChannelMixerGreen;
    float3 _ChannelMixerBlue;
    float3 _Lift;
    float3 _InvGamma;
    float3 _Gain;
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
    sampler sampler_Curves [[ sampler (0) ]],
    texture2d<half, access::sample > _Curves [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    half u_xlat16_1;
    float4 u_xlat2;
    float3 u_xlat3;
    float2 u_xlat4;
    bool u_xlatb4;
    float3 u_xlat5;
    float2 u_xlat10;
    float2 u_xlat11;
    float u_xlat12;
    bool u_xlatb12;
    u_xlat0.yz = input.TEXCOORD1.xy + (-FGlobals._Lut2D_Params.yz);
    u_xlat1.x = u_xlat0.y * FGlobals._Lut2D_Params.x;
    u_xlat0.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat0.x / FGlobals._Lut2D_Params.x;
    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xzw * FGlobals._Lut2D_Params.www;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(FGlobals._Brightness), float3(-0.217637643, -0.217637643, -0.217637643));
    u_xlat0.xyz = fma(u_xlat0.xyz, FGlobals._HueSatCon.xyzx.zzz, float3(0.217637643, 0.217637643, 0.217637643));
    u_xlat1.x = dot(float3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
    u_xlat1.y = dot(float3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
    u_xlat1.z = dot(float3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorBalance.xyzx.xyz;
    u_xlat1.x = dot(float3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
    u_xlat1.y = dot(float3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
    u_xlat1.z = dot(float3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorFilter.xyzx.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, FGlobals._ChannelMixerRed.xyzx.xyz);
    u_xlat1.y = dot(u_xlat0.xyz, FGlobals._ChannelMixerGreen.xyzx.xyz);
    u_xlat1.z = dot(u_xlat0.xyz, FGlobals._ChannelMixerBlue.xyzx.xyz);
    u_xlat0.xyz = fma(u_xlat1.xyz, FGlobals._Gain.xyzx.xyz, FGlobals._Lift.xyzx.xyz);
    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38), float3(0.5, 0.5, 0.5));
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(2.0, 2.0, 2.0), float3(-1.0, -1.0, -1.0));
    u_xlat1.xyz = u_xlat1.xyz * FGlobals._InvGamma.xyzx.xyz;
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlatb12 = u_xlat0.y>=u_xlat0.z;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat1.xy = u_xlat0.zy;
    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
    u_xlat1.z = float(-1.0);
    u_xlat1.w = float(0.666666687);
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(-1.0);
    u_xlat1 = fma(float4(u_xlat12), u_xlat2.xywz, u_xlat1.xywz);
    u_xlatb12 = u_xlat0.x>=u_xlat1.x;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat2.z = u_xlat1.w;
    u_xlat1.w = u_xlat0.x;
    u_xlat3.x = dot(u_xlat0.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat2.xyw = u_xlat1.wyx;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = fma(float4(u_xlat12), u_xlat2, u_xlat1);
    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
    u_xlat5.x = fma(u_xlat1.x, 6.0, 9.99999975e-05);
    u_xlat4.x = (-u_xlat0.y) + u_xlat0.w;
    u_xlat4.x = u_xlat4.x / u_xlat5.x;
    u_xlat4.x = u_xlat4.x + u_xlat0.z;
    u_xlat2.x = abs(u_xlat4.x);
    u_xlat11.x = u_xlat2.x + FGlobals._HueSatCon.xyzx.x;
    u_xlat3.y = float(0.25);
    u_xlat11.y = float(0.25);
    u_xlat4.x = float(_Curves.sample(sampler_Curves, u_xlat11.xy, level(0.0)).x);
    u_xlat4.y = float(_Curves.sample(sampler_Curves, u_xlat3.xy, level(0.0)).w);
    u_xlat4.xy = u_xlat4.xy;
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
    u_xlat4.x = u_xlat11.x + u_xlat4.x;
    u_xlat5.xyz = u_xlat4.xxx + float3(-0.5, 0.5, -1.5);
    u_xlatb4 = 1.0<u_xlat5.x;
    u_xlat4.x = (u_xlatb4) ? u_xlat5.z : u_xlat5.x;
    u_xlatb12 = u_xlat5.x<0.0;
    u_xlat4.x = (u_xlatb12) ? u_xlat5.y : u_xlat4.x;
    u_xlat5.xyz = u_xlat4.xxx + float3(1.0, 0.666666687, 0.333333343);
    u_xlat5.xyz = fract(u_xlat5.xyz);
    u_xlat5.xyz = fma(u_xlat5.xyz, float3(6.0, 6.0, 6.0), float3(-3.0, -3.0, -3.0));
    u_xlat5.xyz = abs(u_xlat5.xyz) + float3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0f, 1.0f);
    u_xlat5.xyz = u_xlat5.xyz + float3(-1.0, -1.0, -1.0);
    u_xlat4.x = u_xlat0.x + 9.99999975e-05;
    u_xlat10.x = u_xlat1.x / u_xlat4.x;
    u_xlat1.xyz = fma(u_xlat10.xxx, u_xlat5.xyz, float3(1.0, 1.0, 1.0));
    u_xlat3.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat1.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, (-u_xlat4.xxx));
    u_xlat2.y = float(0.25);
    u_xlat10.y = float(0.25);
    u_xlat0.x = float(_Curves.sample(sampler_Curves, u_xlat2.xy, level(0.0)).y);
    u_xlat0.w = float(_Curves.sample(sampler_Curves, u_xlat10.xy, level(0.0)).z);
    u_xlat0.xw = u_xlat0.xw;
    u_xlat0.xw = clamp(u_xlat0.xw, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = dot(u_xlat0.ww, u_xlat0.xx);
    u_xlat0.x = u_xlat0.x * u_xlat4.y;
    u_xlat0.x = dot(FGlobals._HueSatCon.xyzx.yy, u_xlat0.xx);
    u_xlat0.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, u_xlat4.xxx);
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz + float3(0.00390625, 0.00390625, 0.00390625);
    u_xlat0.w = 0.75;
    u_xlat16_1 = _Curves.sample(sampler_Curves, u_xlat0.xw).w;
    u_xlat1.x = float(u_xlat16_1);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat5.x = float(_Curves.sample(sampler_Curves, u_xlat0.yw).w);
    u_xlat5.y = float(_Curves.sample(sampler_Curves, u_xlat0.zw).w);
    u_xlat1.yz = u_xlat5.xy;
    u_xlat1.yz = clamp(u_xlat1.yz, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat1.xyz + float3(0.00390625, 0.00390625, 0.00390625);
    u_xlat0.w = 0.75;
    u_xlat16_0 = _Curves.sample(sampler_Curves, u_xlat0.xw).x;
    output.SV_Target0.x = float(u_xlat16_0);
    output.SV_Target0.x = clamp(output.SV_Target0.x, 0.0f, 1.0f);
    u_xlat0.x = float(_Curves.sample(sampler_Curves, u_xlat0.yw).y);
    u_xlat0.y = float(_Curves.sample(sampler_Curves, u_xlat0.zw).z);
    output.SV_Target0.yz = u_xlat0.xy;
    output.SV_Target0.yz = clamp(output.SV_Target0.yz, 0.0f, 1.0f);
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
    float4 _Lut2D_Params;
    float3 _ColorBalance;
    float3 _ColorFilter;
    float3 _HueSatCon;
    float _Brightness;
    float3 _ChannelMixerRed;
    float3 _ChannelMixerGreen;
    float3 _ChannelMixerBlue;
    float3 _Lift;
    float3 _InvGamma;
    float3 _Gain;
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
    sampler sampler_Curves [[ sampler (0) ]],
    texture2d<half, access::sample > _Curves [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    float4 u_xlat1;
    half u_xlat16_1;
    float4 u_xlat2;
    float3 u_xlat3;
    float2 u_xlat4;
    bool u_xlatb4;
    float3 u_xlat5;
    float2 u_xlat10;
    float2 u_xlat11;
    float u_xlat12;
    bool u_xlatb12;
    u_xlat0.yz = input.TEXCOORD1.xy + (-FGlobals._Lut2D_Params.yz);
    u_xlat1.x = u_xlat0.y * FGlobals._Lut2D_Params.x;
    u_xlat0.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat0.x / FGlobals._Lut2D_Params.x;
    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xzw * FGlobals._Lut2D_Params.www;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(FGlobals._Brightness), float3(-0.217637643, -0.217637643, -0.217637643));
    u_xlat0.xyz = fma(u_xlat0.xyz, FGlobals._HueSatCon.xyzx.zzz, float3(0.217637643, 0.217637643, 0.217637643));
    u_xlat1.x = dot(float3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
    u_xlat1.y = dot(float3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
    u_xlat1.z = dot(float3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorBalance.xyzx.xyz;
    u_xlat1.x = dot(float3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
    u_xlat1.y = dot(float3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
    u_xlat1.z = dot(float3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorFilter.xyzx.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, FGlobals._ChannelMixerRed.xyzx.xyz);
    u_xlat1.y = dot(u_xlat0.xyz, FGlobals._ChannelMixerGreen.xyzx.xyz);
    u_xlat1.z = dot(u_xlat0.xyz, FGlobals._ChannelMixerBlue.xyzx.xyz);
    u_xlat0.xyz = fma(u_xlat1.xyz, FGlobals._Gain.xyzx.xyz, FGlobals._Lift.xyzx.xyz);
    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38), float3(0.5, 0.5, 0.5));
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(2.0, 2.0, 2.0), float3(-1.0, -1.0, -1.0));
    u_xlat1.xyz = u_xlat1.xyz * FGlobals._InvGamma.xyzx.xyz;
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlatb12 = u_xlat0.y>=u_xlat0.z;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat1.xy = u_xlat0.zy;
    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
    u_xlat1.z = float(-1.0);
    u_xlat1.w = float(0.666666687);
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(-1.0);
    u_xlat1 = fma(float4(u_xlat12), u_xlat2.xywz, u_xlat1.xywz);
    u_xlatb12 = u_xlat0.x>=u_xlat1.x;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat2.z = u_xlat1.w;
    u_xlat1.w = u_xlat0.x;
    u_xlat3.x = dot(u_xlat0.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat2.xyw = u_xlat1.wyx;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = fma(float4(u_xlat12), u_xlat2, u_xlat1);
    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
    u_xlat5.x = fma(u_xlat1.x, 6.0, 9.99999975e-05);
    u_xlat4.x = (-u_xlat0.y) + u_xlat0.w;
    u_xlat4.x = u_xlat4.x / u_xlat5.x;
    u_xlat4.x = u_xlat4.x + u_xlat0.z;
    u_xlat2.x = abs(u_xlat4.x);
    u_xlat11.x = u_xlat2.x + FGlobals._HueSatCon.xyzx.x;
    u_xlat3.y = float(0.25);
    u_xlat11.y = float(0.25);
    u_xlat4.x = float(_Curves.sample(sampler_Curves, u_xlat11.xy, level(0.0)).x);
    u_xlat4.y = float(_Curves.sample(sampler_Curves, u_xlat3.xy, level(0.0)).w);
    u_xlat4.xy = u_xlat4.xy;
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
    u_xlat4.x = u_xlat11.x + u_xlat4.x;
    u_xlat5.xyz = u_xlat4.xxx + float3(-0.5, 0.5, -1.5);
    u_xlatb4 = 1.0<u_xlat5.x;
    u_xlat4.x = (u_xlatb4) ? u_xlat5.z : u_xlat5.x;
    u_xlatb12 = u_xlat5.x<0.0;
    u_xlat4.x = (u_xlatb12) ? u_xlat5.y : u_xlat4.x;
    u_xlat5.xyz = u_xlat4.xxx + float3(1.0, 0.666666687, 0.333333343);
    u_xlat5.xyz = fract(u_xlat5.xyz);
    u_xlat5.xyz = fma(u_xlat5.xyz, float3(6.0, 6.0, 6.0), float3(-3.0, -3.0, -3.0));
    u_xlat5.xyz = abs(u_xlat5.xyz) + float3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0f, 1.0f);
    u_xlat5.xyz = u_xlat5.xyz + float3(-1.0, -1.0, -1.0);
    u_xlat4.x = u_xlat0.x + 9.99999975e-05;
    u_xlat10.x = u_xlat1.x / u_xlat4.x;
    u_xlat1.xyz = fma(u_xlat10.xxx, u_xlat5.xyz, float3(1.0, 1.0, 1.0));
    u_xlat3.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat1.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, (-u_xlat4.xxx));
    u_xlat2.y = float(0.25);
    u_xlat10.y = float(0.25);
    u_xlat0.x = float(_Curves.sample(sampler_Curves, u_xlat2.xy, level(0.0)).y);
    u_xlat0.w = float(_Curves.sample(sampler_Curves, u_xlat10.xy, level(0.0)).z);
    u_xlat0.xw = u_xlat0.xw;
    u_xlat0.xw = clamp(u_xlat0.xw, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = dot(u_xlat0.ww, u_xlat0.xx);
    u_xlat0.x = u_xlat0.x * u_xlat4.y;
    u_xlat0.x = dot(FGlobals._HueSatCon.xyzx.yy, u_xlat0.xx);
    u_xlat0.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, u_xlat4.xxx);
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz + float3(0.00390625, 0.00390625, 0.00390625);
    u_xlat0.w = 0.75;
    u_xlat16_1 = _Curves.sample(sampler_Curves, u_xlat0.xw).w;
    u_xlat1.x = float(u_xlat16_1);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat5.x = float(_Curves.sample(sampler_Curves, u_xlat0.yw).w);
    u_xlat5.y = float(_Curves.sample(sampler_Curves, u_xlat0.zw).w);
    u_xlat1.yz = u_xlat5.xy;
    u_xlat1.yz = clamp(u_xlat1.yz, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat1.xyz + float3(0.00390625, 0.00390625, 0.00390625);
    u_xlat0.w = 0.75;
    u_xlat16_0 = _Curves.sample(sampler_Curves, u_xlat0.xw).x;
    output.SV_Target0.x = float(u_xlat16_0);
    output.SV_Target0.x = clamp(output.SV_Target0.x, 0.0f, 1.0f);
    u_xlat0.x = float(_Curves.sample(sampler_Curves, u_xlat0.yw).y);
    u_xlat0.y = float(_Curves.sample(sampler_Curves, u_xlat0.zw).z);
    output.SV_Target0.yz = u_xlat0.xy;
    output.SV_Target0.yz = clamp(output.SV_Target0.yz, 0.0f, 1.0f);
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
  GpuProgramID 96087
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
    float4 _Lut2D_Params;
    float4 _UserLut2D_Params;
    float3 _ColorBalance;
    float3 _ColorFilter;
    float3 _HueSatCon;
    float _Brightness;
    float3 _ChannelMixerRed;
    float3 _ChannelMixerGreen;
    float3 _ChannelMixerBlue;
    float3 _Lift;
    float3 _InvGamma;
    float3 _Gain;
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
    sampler sampler_Curves [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Curves [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half u_xlat16_1;
    float4 u_xlat2;
    float4 u_xlat3;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    float3 u_xlat5;
    half u_xlat16_5;
    bool u_xlatb5;
    float2 u_xlat6;
    bool u_xlatb6;
    float u_xlat7;
    float2 u_xlat10;
    float2 u_xlat11;
    float u_xlat15;
    u_xlat0.x = FGlobals._UserLut2D_Params.y;
    u_xlat1.yz = input.TEXCOORD1.xy + (-FGlobals._Lut2D_Params.yz);
    u_xlat2.x = u_xlat1.y * FGlobals._Lut2D_Params.x;
    u_xlat1.x = fract(u_xlat2.x);
    u_xlat2.x = u_xlat1.x / FGlobals._Lut2D_Params.x;
    u_xlat1.w = u_xlat1.y + (-u_xlat2.x);
    u_xlat2.xyz = u_xlat1.xzw * FGlobals._Lut2D_Params.www;
    u_xlat3.xyz = u_xlat2.zxy * FGlobals._UserLut2D_Params.zzz;
    u_xlat6.x = floor(u_xlat3.x);
    u_xlat3.xw = FGlobals._UserLut2D_Params.xy * float2(0.5, 0.5);
    u_xlat3.yz = fma(u_xlat3.yz, FGlobals._UserLut2D_Params.xy, u_xlat3.xw);
    u_xlat3.x = fma(u_xlat6.x, FGlobals._UserLut2D_Params.y, u_xlat3.y);
    u_xlat6.x = fma(u_xlat2.z, FGlobals._UserLut2D_Params.z, (-u_xlat6.x));
    u_xlat0.y = float(0.0);
    u_xlat10.y = float(0.25);
    u_xlat0.xy = u_xlat0.xy + u_xlat3.xz;
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, u_xlat3.xz).xyz;
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_4.xyz;
    u_xlat3.xyz = fma(u_xlat6.xxx, float3(u_xlat16_4.xyz), float3(u_xlat16_3.xyz));
    u_xlat1.xyz = fma((-u_xlat1.xzw), FGlobals._Lut2D_Params.www, u_xlat3.xyz);
    u_xlat1.xyz = fma(FGlobals._UserLut2D_Params.www, u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(FGlobals._Brightness), float3(-0.217637643, -0.217637643, -0.217637643));
    u_xlat1.xyz = fma(u_xlat1.xyz, FGlobals._HueSatCon.xyzx.zzz, float3(0.217637643, 0.217637643, 0.217637643));
    u_xlat2.x = dot(float3(0.390404999, 0.549941003, 0.00892631989), u_xlat1.xyz);
    u_xlat2.y = dot(float3(0.070841603, 0.963172019, 0.00135775004), u_xlat1.xyz);
    u_xlat2.z = dot(float3(0.0231081992, 0.128021002, 0.936245024), u_xlat1.xyz);
    u_xlat1.xyz = u_xlat2.xyz * FGlobals._ColorBalance.xyzx.xyz;
    u_xlat2.x = dot(float3(2.85846996, -1.62879002, -0.0248910002), u_xlat1.xyz);
    u_xlat2.y = dot(float3(-0.210181996, 1.15820003, 0.000324280991), u_xlat1.xyz);
    u_xlat2.z = dot(float3(-0.0418119989, -0.118169002, 1.06867003), u_xlat1.xyz);
    u_xlat1.xyz = u_xlat2.xyz * FGlobals._ColorFilter.xyzx.xyz;
    u_xlat2.x = dot(u_xlat1.xyz, FGlobals._ChannelMixerRed.xyzx.xyz);
    u_xlat2.y = dot(u_xlat1.xyz, FGlobals._ChannelMixerGreen.xyzx.xyz);
    u_xlat2.z = dot(u_xlat1.xyz, FGlobals._ChannelMixerBlue.xyzx.xyz);
    u_xlat1.xyz = fma(u_xlat2.xyz, FGlobals._Gain.xyzx.xyz, FGlobals._Lift.xyzx.xyz);
    u_xlat2.xyz = log2(abs(u_xlat1.xyz));
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38), float3(0.5, 0.5, 0.5));
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0f, 1.0f);
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(2.0, 2.0, 2.0), float3(-1.0, -1.0, -1.0));
    u_xlat2.xyz = u_xlat2.xyz * FGlobals._InvGamma.xyzx.xyz;
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = max(u_xlat1.xyz, float3(0.0, 0.0, 0.0));
    u_xlatb0 = u_xlat1.y>=u_xlat1.z;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat2.xy = u_xlat1.zy;
    u_xlat3.xy = u_xlat1.yz + (-u_xlat2.xy);
    u_xlat2.z = float(-1.0);
    u_xlat2.w = float(0.666666687);
    u_xlat3.z = float(1.0);
    u_xlat3.w = float(-1.0);
    u_xlat2 = fma(u_xlat0.xxxx, u_xlat3.xywz, u_xlat2.xywz);
    u_xlatb0 = u_xlat1.x>=u_xlat2.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat3.z = u_xlat2.w;
    u_xlat2.w = u_xlat1.x;
    u_xlat11.x = dot(u_xlat1.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat3.xyw = u_xlat2.wyx;
    u_xlat3 = (-u_xlat2) + u_xlat3;
    u_xlat2 = fma(u_xlat0.xxxx, u_xlat3, u_xlat2);
    u_xlat0.x = min(u_xlat2.y, u_xlat2.w);
    u_xlat0.x = (-u_xlat0.x) + u_xlat2.x;
    u_xlat5.x = fma(u_xlat0.x, 6.0, 9.99999975e-05);
    u_xlat7 = (-u_xlat2.y) + u_xlat2.w;
    u_xlat5.x = u_xlat7 / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + u_xlat2.z;
    u_xlat10.x = abs(u_xlat5.x);
    u_xlat16_5 = _Curves.sample(sampler_Curves, u_xlat10.xy, level(0.0)).y;
    u_xlat3.x = u_xlat10.x + FGlobals._HueSatCon.xyzx.x;
    u_xlat16_5 = u_xlat16_5;
    u_xlat16_5 = clamp(u_xlat16_5, 0.0h, 1.0h);
    u_xlat16_5 = u_xlat16_5 + u_xlat16_5;
    u_xlat10.x = u_xlat2.x + 9.99999975e-05;
    u_xlat1.x = u_xlat0.x / u_xlat10.x;
    u_xlat1.y = float(0.25);
    u_xlat11.y = float(0.25);
    u_xlat0.x = float(_Curves.sample(sampler_Curves, u_xlat1.xy, level(0.0)).z);
    u_xlat0.z = float(_Curves.sample(sampler_Curves, u_xlat11.xy, level(0.0)).w);
    u_xlat0.xz = u_xlat0.xz;
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat0.xx, float2(u_xlat16_5));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlat0.x = dot(FGlobals._HueSatCon.xyzx.yy, u_xlat0.xx);
    u_xlat3.y = 0.25;
    u_xlat16_5 = _Curves.sample(sampler_Curves, u_xlat3.xy, level(0.0)).x;
    u_xlat16_5 = u_xlat16_5;
    u_xlat16_5 = clamp(u_xlat16_5, 0.0h, 1.0h);
    u_xlat5.x = u_xlat3.x + float(u_xlat16_5);
    u_xlat5.xyz = u_xlat5.xxx + float3(-0.5, 0.5, -1.5);
    u_xlatb6 = 1.0<u_xlat5.x;
    u_xlat15 = (u_xlatb6) ? u_xlat5.z : u_xlat5.x;
    u_xlatb5 = u_xlat5.x<0.0;
    u_xlat5.x = (u_xlatb5) ? u_xlat5.y : u_xlat15;
    u_xlat5.xyz = u_xlat5.xxx + float3(1.0, 0.666666687, 0.333333343);
    u_xlat5.xyz = fract(u_xlat5.xyz);
    u_xlat5.xyz = fma(u_xlat5.xyz, float3(6.0, 6.0, 6.0), float3(-3.0, -3.0, -3.0));
    u_xlat5.xyz = abs(u_xlat5.xyz) + float3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0f, 1.0f);
    u_xlat5.xyz = u_xlat5.xyz + float3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = fma(u_xlat1.xxx, u_xlat5.xyz, float3(1.0, 1.0, 1.0));
    u_xlat1.xyz = u_xlat5.xyz * u_xlat2.xxx;
    u_xlat1.x = dot(u_xlat1.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat5.xyz = fma(u_xlat2.xxx, u_xlat5.xyz, (-u_xlat1.xxx));
    u_xlat0.xyz = fma(u_xlat0.xxx, u_xlat5.xyz, u_xlat1.xxx);
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz + float3(0.00390625, 0.00390625, 0.00390625);
    u_xlat0.w = 0.75;
    u_xlat16_1 = _Curves.sample(sampler_Curves, u_xlat0.xw).w;
    u_xlat1.x = float(u_xlat16_1);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat6.x = float(_Curves.sample(sampler_Curves, u_xlat0.yw).w);
    u_xlat6.y = float(_Curves.sample(sampler_Curves, u_xlat0.zw).w);
    u_xlat1.yz = u_xlat6.xy;
    u_xlat1.yz = clamp(u_xlat1.yz, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat1.xyz + float3(0.00390625, 0.00390625, 0.00390625);
    u_xlat0.w = 0.75;
    u_xlat16_0 = _Curves.sample(sampler_Curves, u_xlat0.xw).x;
    output.SV_Target0.x = float(u_xlat16_0);
    output.SV_Target0.x = clamp(output.SV_Target0.x, 0.0f, 1.0f);
    u_xlat0.x = float(_Curves.sample(sampler_Curves, u_xlat0.yw).y);
    u_xlat0.y = float(_Curves.sample(sampler_Curves, u_xlat0.zw).z);
    output.SV_Target0.yz = u_xlat0.xy;
    output.SV_Target0.yz = clamp(output.SV_Target0.yz, 0.0f, 1.0f);
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
    float4 _Lut2D_Params;
    float4 _UserLut2D_Params;
    float3 _ColorBalance;
    float3 _ColorFilter;
    float3 _HueSatCon;
    float _Brightness;
    float3 _ChannelMixerRed;
    float3 _ChannelMixerGreen;
    float3 _ChannelMixerBlue;
    float3 _Lift;
    float3 _InvGamma;
    float3 _Gain;
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
    sampler sampler_Curves [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Curves [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half u_xlat16_1;
    float4 u_xlat2;
    float4 u_xlat3;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    float3 u_xlat5;
    half u_xlat16_5;
    bool u_xlatb5;
    float2 u_xlat6;
    bool u_xlatb6;
    float u_xlat7;
    float2 u_xlat10;
    float2 u_xlat11;
    float u_xlat15;
    u_xlat0.x = FGlobals._UserLut2D_Params.y;
    u_xlat1.yz = input.TEXCOORD1.xy + (-FGlobals._Lut2D_Params.yz);
    u_xlat2.x = u_xlat1.y * FGlobals._Lut2D_Params.x;
    u_xlat1.x = fract(u_xlat2.x);
    u_xlat2.x = u_xlat1.x / FGlobals._Lut2D_Params.x;
    u_xlat1.w = u_xlat1.y + (-u_xlat2.x);
    u_xlat2.xyz = u_xlat1.xzw * FGlobals._Lut2D_Params.www;
    u_xlat3.xyz = u_xlat2.zxy * FGlobals._UserLut2D_Params.zzz;
    u_xlat6.x = floor(u_xlat3.x);
    u_xlat3.xw = FGlobals._UserLut2D_Params.xy * float2(0.5, 0.5);
    u_xlat3.yz = fma(u_xlat3.yz, FGlobals._UserLut2D_Params.xy, u_xlat3.xw);
    u_xlat3.x = fma(u_xlat6.x, FGlobals._UserLut2D_Params.y, u_xlat3.y);
    u_xlat6.x = fma(u_xlat2.z, FGlobals._UserLut2D_Params.z, (-u_xlat6.x));
    u_xlat0.y = float(0.0);
    u_xlat10.y = float(0.25);
    u_xlat0.xy = u_xlat0.xy + u_xlat3.xz;
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, u_xlat3.xz).xyz;
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_4.xyz;
    u_xlat3.xyz = fma(u_xlat6.xxx, float3(u_xlat16_4.xyz), float3(u_xlat16_3.xyz));
    u_xlat1.xyz = fma((-u_xlat1.xzw), FGlobals._Lut2D_Params.www, u_xlat3.xyz);
    u_xlat1.xyz = fma(FGlobals._UserLut2D_Params.www, u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(FGlobals._Brightness), float3(-0.217637643, -0.217637643, -0.217637643));
    u_xlat1.xyz = fma(u_xlat1.xyz, FGlobals._HueSatCon.xyzx.zzz, float3(0.217637643, 0.217637643, 0.217637643));
    u_xlat2.x = dot(float3(0.390404999, 0.549941003, 0.00892631989), u_xlat1.xyz);
    u_xlat2.y = dot(float3(0.070841603, 0.963172019, 0.00135775004), u_xlat1.xyz);
    u_xlat2.z = dot(float3(0.0231081992, 0.128021002, 0.936245024), u_xlat1.xyz);
    u_xlat1.xyz = u_xlat2.xyz * FGlobals._ColorBalance.xyzx.xyz;
    u_xlat2.x = dot(float3(2.85846996, -1.62879002, -0.0248910002), u_xlat1.xyz);
    u_xlat2.y = dot(float3(-0.210181996, 1.15820003, 0.000324280991), u_xlat1.xyz);
    u_xlat2.z = dot(float3(-0.0418119989, -0.118169002, 1.06867003), u_xlat1.xyz);
    u_xlat1.xyz = u_xlat2.xyz * FGlobals._ColorFilter.xyzx.xyz;
    u_xlat2.x = dot(u_xlat1.xyz, FGlobals._ChannelMixerRed.xyzx.xyz);
    u_xlat2.y = dot(u_xlat1.xyz, FGlobals._ChannelMixerGreen.xyzx.xyz);
    u_xlat2.z = dot(u_xlat1.xyz, FGlobals._ChannelMixerBlue.xyzx.xyz);
    u_xlat1.xyz = fma(u_xlat2.xyz, FGlobals._Gain.xyzx.xyz, FGlobals._Lift.xyzx.xyz);
    u_xlat2.xyz = log2(abs(u_xlat1.xyz));
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38), float3(0.5, 0.5, 0.5));
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0f, 1.0f);
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(2.0, 2.0, 2.0), float3(-1.0, -1.0, -1.0));
    u_xlat2.xyz = u_xlat2.xyz * FGlobals._InvGamma.xyzx.xyz;
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = max(u_xlat1.xyz, float3(0.0, 0.0, 0.0));
    u_xlatb0 = u_xlat1.y>=u_xlat1.z;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat2.xy = u_xlat1.zy;
    u_xlat3.xy = u_xlat1.yz + (-u_xlat2.xy);
    u_xlat2.z = float(-1.0);
    u_xlat2.w = float(0.666666687);
    u_xlat3.z = float(1.0);
    u_xlat3.w = float(-1.0);
    u_xlat2 = fma(u_xlat0.xxxx, u_xlat3.xywz, u_xlat2.xywz);
    u_xlatb0 = u_xlat1.x>=u_xlat2.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat3.z = u_xlat2.w;
    u_xlat2.w = u_xlat1.x;
    u_xlat11.x = dot(u_xlat1.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat3.xyw = u_xlat2.wyx;
    u_xlat3 = (-u_xlat2) + u_xlat3;
    u_xlat2 = fma(u_xlat0.xxxx, u_xlat3, u_xlat2);
    u_xlat0.x = min(u_xlat2.y, u_xlat2.w);
    u_xlat0.x = (-u_xlat0.x) + u_xlat2.x;
    u_xlat5.x = fma(u_xlat0.x, 6.0, 9.99999975e-05);
    u_xlat7 = (-u_xlat2.y) + u_xlat2.w;
    u_xlat5.x = u_xlat7 / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + u_xlat2.z;
    u_xlat10.x = abs(u_xlat5.x);
    u_xlat16_5 = _Curves.sample(sampler_Curves, u_xlat10.xy, level(0.0)).y;
    u_xlat3.x = u_xlat10.x + FGlobals._HueSatCon.xyzx.x;
    u_xlat16_5 = u_xlat16_5;
    u_xlat16_5 = clamp(u_xlat16_5, 0.0h, 1.0h);
    u_xlat16_5 = u_xlat16_5 + u_xlat16_5;
    u_xlat10.x = u_xlat2.x + 9.99999975e-05;
    u_xlat1.x = u_xlat0.x / u_xlat10.x;
    u_xlat1.y = float(0.25);
    u_xlat11.y = float(0.25);
    u_xlat0.x = float(_Curves.sample(sampler_Curves, u_xlat1.xy, level(0.0)).z);
    u_xlat0.z = float(_Curves.sample(sampler_Curves, u_xlat11.xy, level(0.0)).w);
    u_xlat0.xz = u_xlat0.xz;
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat0.xx, float2(u_xlat16_5));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlat0.x = dot(FGlobals._HueSatCon.xyzx.yy, u_xlat0.xx);
    u_xlat3.y = 0.25;
    u_xlat16_5 = _Curves.sample(sampler_Curves, u_xlat3.xy, level(0.0)).x;
    u_xlat16_5 = u_xlat16_5;
    u_xlat16_5 = clamp(u_xlat16_5, 0.0h, 1.0h);
    u_xlat5.x = u_xlat3.x + float(u_xlat16_5);
    u_xlat5.xyz = u_xlat5.xxx + float3(-0.5, 0.5, -1.5);
    u_xlatb6 = 1.0<u_xlat5.x;
    u_xlat15 = (u_xlatb6) ? u_xlat5.z : u_xlat5.x;
    u_xlatb5 = u_xlat5.x<0.0;
    u_xlat5.x = (u_xlatb5) ? u_xlat5.y : u_xlat15;
    u_xlat5.xyz = u_xlat5.xxx + float3(1.0, 0.666666687, 0.333333343);
    u_xlat5.xyz = fract(u_xlat5.xyz);
    u_xlat5.xyz = fma(u_xlat5.xyz, float3(6.0, 6.0, 6.0), float3(-3.0, -3.0, -3.0));
    u_xlat5.xyz = abs(u_xlat5.xyz) + float3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0f, 1.0f);
    u_xlat5.xyz = u_xlat5.xyz + float3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = fma(u_xlat1.xxx, u_xlat5.xyz, float3(1.0, 1.0, 1.0));
    u_xlat1.xyz = u_xlat5.xyz * u_xlat2.xxx;
    u_xlat1.x = dot(u_xlat1.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat5.xyz = fma(u_xlat2.xxx, u_xlat5.xyz, (-u_xlat1.xxx));
    u_xlat0.xyz = fma(u_xlat0.xxx, u_xlat5.xyz, u_xlat1.xxx);
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz + float3(0.00390625, 0.00390625, 0.00390625);
    u_xlat0.w = 0.75;
    u_xlat16_1 = _Curves.sample(sampler_Curves, u_xlat0.xw).w;
    u_xlat1.x = float(u_xlat16_1);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat6.x = float(_Curves.sample(sampler_Curves, u_xlat0.yw).w);
    u_xlat6.y = float(_Curves.sample(sampler_Curves, u_xlat0.zw).w);
    u_xlat1.yz = u_xlat6.xy;
    u_xlat1.yz = clamp(u_xlat1.yz, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat1.xyz + float3(0.00390625, 0.00390625, 0.00390625);
    u_xlat0.w = 0.75;
    u_xlat16_0 = _Curves.sample(sampler_Curves, u_xlat0.xw).x;
    output.SV_Target0.x = float(u_xlat16_0);
    output.SV_Target0.x = clamp(output.SV_Target0.x, 0.0f, 1.0f);
    u_xlat0.x = float(_Curves.sample(sampler_Curves, u_xlat0.yw).y);
    u_xlat0.y = float(_Curves.sample(sampler_Curves, u_xlat0.zw).z);
    output.SV_Target0.yz = u_xlat0.xy;
    output.SV_Target0.yz = clamp(output.SV_Target0.yz, 0.0f, 1.0f);
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
    float4 _Lut2D_Params;
    float4 _UserLut2D_Params;
    float3 _ColorBalance;
    float3 _ColorFilter;
    float3 _HueSatCon;
    float _Brightness;
    float3 _ChannelMixerRed;
    float3 _ChannelMixerGreen;
    float3 _ChannelMixerBlue;
    float3 _Lift;
    float3 _InvGamma;
    float3 _Gain;
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
    sampler sampler_Curves [[ sampler (1) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _Curves [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    half u_xlat16_1;
    float4 u_xlat2;
    float4 u_xlat3;
    half3 u_xlat16_3;
    half3 u_xlat16_4;
    float3 u_xlat5;
    half u_xlat16_5;
    bool u_xlatb5;
    float2 u_xlat6;
    bool u_xlatb6;
    float u_xlat7;
    float2 u_xlat10;
    float2 u_xlat11;
    float u_xlat15;
    u_xlat0.x = FGlobals._UserLut2D_Params.y;
    u_xlat1.yz = input.TEXCOORD1.xy + (-FGlobals._Lut2D_Params.yz);
    u_xlat2.x = u_xlat1.y * FGlobals._Lut2D_Params.x;
    u_xlat1.x = fract(u_xlat2.x);
    u_xlat2.x = u_xlat1.x / FGlobals._Lut2D_Params.x;
    u_xlat1.w = u_xlat1.y + (-u_xlat2.x);
    u_xlat2.xyz = u_xlat1.xzw * FGlobals._Lut2D_Params.www;
    u_xlat3.xyz = u_xlat2.zxy * FGlobals._UserLut2D_Params.zzz;
    u_xlat6.x = floor(u_xlat3.x);
    u_xlat3.xw = FGlobals._UserLut2D_Params.xy * float2(0.5, 0.5);
    u_xlat3.yz = fma(u_xlat3.yz, FGlobals._UserLut2D_Params.xy, u_xlat3.xw);
    u_xlat3.x = fma(u_xlat6.x, FGlobals._UserLut2D_Params.y, u_xlat3.y);
    u_xlat6.x = fma(u_xlat2.z, FGlobals._UserLut2D_Params.z, (-u_xlat6.x));
    u_xlat0.y = float(0.0);
    u_xlat10.y = float(0.25);
    u_xlat0.xy = u_xlat0.xy + u_xlat3.xz;
    u_xlat16_3.xyz = _MainTex.sample(sampler_MainTex, u_xlat3.xz).xyz;
    u_xlat16_4.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.xy).xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat16_4.xyz;
    u_xlat3.xyz = fma(u_xlat6.xxx, float3(u_xlat16_4.xyz), float3(u_xlat16_3.xyz));
    u_xlat1.xyz = fma((-u_xlat1.xzw), FGlobals._Lut2D_Params.www, u_xlat3.xyz);
    u_xlat1.xyz = fma(FGlobals._UserLut2D_Params.www, u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(FGlobals._Brightness), float3(-0.217637643, -0.217637643, -0.217637643));
    u_xlat1.xyz = fma(u_xlat1.xyz, FGlobals._HueSatCon.xyzx.zzz, float3(0.217637643, 0.217637643, 0.217637643));
    u_xlat2.x = dot(float3(0.390404999, 0.549941003, 0.00892631989), u_xlat1.xyz);
    u_xlat2.y = dot(float3(0.070841603, 0.963172019, 0.00135775004), u_xlat1.xyz);
    u_xlat2.z = dot(float3(0.0231081992, 0.128021002, 0.936245024), u_xlat1.xyz);
    u_xlat1.xyz = u_xlat2.xyz * FGlobals._ColorBalance.xyzx.xyz;
    u_xlat2.x = dot(float3(2.85846996, -1.62879002, -0.0248910002), u_xlat1.xyz);
    u_xlat2.y = dot(float3(-0.210181996, 1.15820003, 0.000324280991), u_xlat1.xyz);
    u_xlat2.z = dot(float3(-0.0418119989, -0.118169002, 1.06867003), u_xlat1.xyz);
    u_xlat1.xyz = u_xlat2.xyz * FGlobals._ColorFilter.xyzx.xyz;
    u_xlat2.x = dot(u_xlat1.xyz, FGlobals._ChannelMixerRed.xyzx.xyz);
    u_xlat2.y = dot(u_xlat1.xyz, FGlobals._ChannelMixerGreen.xyzx.xyz);
    u_xlat2.z = dot(u_xlat1.xyz, FGlobals._ChannelMixerBlue.xyzx.xyz);
    u_xlat1.xyz = fma(u_xlat2.xyz, FGlobals._Gain.xyzx.xyz, FGlobals._Lift.xyzx.xyz);
    u_xlat2.xyz = log2(abs(u_xlat1.xyz));
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38), float3(0.5, 0.5, 0.5));
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0f, 1.0f);
    u_xlat1.xyz = fma(u_xlat1.xyz, float3(2.0, 2.0, 2.0), float3(-1.0, -1.0, -1.0));
    u_xlat2.xyz = u_xlat2.xyz * FGlobals._InvGamma.xyzx.xyz;
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = max(u_xlat1.xyz, float3(0.0, 0.0, 0.0));
    u_xlatb0 = u_xlat1.y>=u_xlat1.z;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat2.xy = u_xlat1.zy;
    u_xlat3.xy = u_xlat1.yz + (-u_xlat2.xy);
    u_xlat2.z = float(-1.0);
    u_xlat2.w = float(0.666666687);
    u_xlat3.z = float(1.0);
    u_xlat3.w = float(-1.0);
    u_xlat2 = fma(u_xlat0.xxxx, u_xlat3.xywz, u_xlat2.xywz);
    u_xlatb0 = u_xlat1.x>=u_xlat2.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat3.z = u_xlat2.w;
    u_xlat2.w = u_xlat1.x;
    u_xlat11.x = dot(u_xlat1.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat3.xyw = u_xlat2.wyx;
    u_xlat3 = (-u_xlat2) + u_xlat3;
    u_xlat2 = fma(u_xlat0.xxxx, u_xlat3, u_xlat2);
    u_xlat0.x = min(u_xlat2.y, u_xlat2.w);
    u_xlat0.x = (-u_xlat0.x) + u_xlat2.x;
    u_xlat5.x = fma(u_xlat0.x, 6.0, 9.99999975e-05);
    u_xlat7 = (-u_xlat2.y) + u_xlat2.w;
    u_xlat5.x = u_xlat7 / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + u_xlat2.z;
    u_xlat10.x = abs(u_xlat5.x);
    u_xlat16_5 = _Curves.sample(sampler_Curves, u_xlat10.xy, level(0.0)).y;
    u_xlat3.x = u_xlat10.x + FGlobals._HueSatCon.xyzx.x;
    u_xlat16_5 = u_xlat16_5;
    u_xlat16_5 = clamp(u_xlat16_5, 0.0h, 1.0h);
    u_xlat16_5 = u_xlat16_5 + u_xlat16_5;
    u_xlat10.x = u_xlat2.x + 9.99999975e-05;
    u_xlat1.x = u_xlat0.x / u_xlat10.x;
    u_xlat1.y = float(0.25);
    u_xlat11.y = float(0.25);
    u_xlat0.x = float(_Curves.sample(sampler_Curves, u_xlat1.xy, level(0.0)).z);
    u_xlat0.z = float(_Curves.sample(sampler_Curves, u_xlat11.xy, level(0.0)).w);
    u_xlat0.xz = u_xlat0.xz;
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat0.xx, float2(u_xlat16_5));
    u_xlat0.x = u_xlat0.x * u_xlat0.z;
    u_xlat0.x = dot(FGlobals._HueSatCon.xyzx.yy, u_xlat0.xx);
    u_xlat3.y = 0.25;
    u_xlat16_5 = _Curves.sample(sampler_Curves, u_xlat3.xy, level(0.0)).x;
    u_xlat16_5 = u_xlat16_5;
    u_xlat16_5 = clamp(u_xlat16_5, 0.0h, 1.0h);
    u_xlat5.x = u_xlat3.x + float(u_xlat16_5);
    u_xlat5.xyz = u_xlat5.xxx + float3(-0.5, 0.5, -1.5);
    u_xlatb6 = 1.0<u_xlat5.x;
    u_xlat15 = (u_xlatb6) ? u_xlat5.z : u_xlat5.x;
    u_xlatb5 = u_xlat5.x<0.0;
    u_xlat5.x = (u_xlatb5) ? u_xlat5.y : u_xlat15;
    u_xlat5.xyz = u_xlat5.xxx + float3(1.0, 0.666666687, 0.333333343);
    u_xlat5.xyz = fract(u_xlat5.xyz);
    u_xlat5.xyz = fma(u_xlat5.xyz, float3(6.0, 6.0, 6.0), float3(-3.0, -3.0, -3.0));
    u_xlat5.xyz = abs(u_xlat5.xyz) + float3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0f, 1.0f);
    u_xlat5.xyz = u_xlat5.xyz + float3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = fma(u_xlat1.xxx, u_xlat5.xyz, float3(1.0, 1.0, 1.0));
    u_xlat1.xyz = u_xlat5.xyz * u_xlat2.xxx;
    u_xlat1.x = dot(u_xlat1.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat5.xyz = fma(u_xlat2.xxx, u_xlat5.xyz, (-u_xlat1.xxx));
    u_xlat0.xyz = fma(u_xlat0.xxx, u_xlat5.xyz, u_xlat1.xxx);
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz + float3(0.00390625, 0.00390625, 0.00390625);
    u_xlat0.w = 0.75;
    u_xlat16_1 = _Curves.sample(sampler_Curves, u_xlat0.xw).w;
    u_xlat1.x = float(u_xlat16_1);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat6.x = float(_Curves.sample(sampler_Curves, u_xlat0.yw).w);
    u_xlat6.y = float(_Curves.sample(sampler_Curves, u_xlat0.zw).w);
    u_xlat1.yz = u_xlat6.xy;
    u_xlat1.yz = clamp(u_xlat1.yz, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat1.xyz + float3(0.00390625, 0.00390625, 0.00390625);
    u_xlat0.w = 0.75;
    u_xlat16_0 = _Curves.sample(sampler_Curves, u_xlat0.xw).x;
    output.SV_Target0.x = float(u_xlat16_0);
    output.SV_Target0.x = clamp(output.SV_Target0.x, 0.0f, 1.0f);
    u_xlat0.x = float(_Curves.sample(sampler_Curves, u_xlat0.yw).y);
    u_xlat0.y = float(_Curves.sample(sampler_Curves, u_xlat0.zw).z);
    output.SV_Target0.yz = u_xlat0.xy;
    output.SV_Target0.yz = clamp(output.SV_Target0.yz, 0.0f, 1.0f);
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
  GpuProgramID 195043
Program "vp" {
SubProgram "metal hw_tier00 " {
Keywords { "TONEMAPPING_ACES" }
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
Keywords { "TONEMAPPING_ACES" }
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
Keywords { "TONEMAPPING_ACES" }
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
SubProgram "metal hw_tier00 " {
Keywords { "TONEMAPPING_NEUTRAL" }
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
Keywords { "TONEMAPPING_NEUTRAL" }
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
Keywords { "TONEMAPPING_NEUTRAL" }
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
SubProgram "metal hw_tier00 " {
Keywords { "TONEMAPPING_CUSTOM" }
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
Keywords { "TONEMAPPING_CUSTOM" }
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
Keywords { "TONEMAPPING_CUSTOM" }
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
    float4 _Lut2D_Params;
    float3 _ColorBalance;
    float3 _ColorFilter;
    float3 _HueSatCon;
    float3 _ChannelMixerRed;
    float3 _ChannelMixerGreen;
    float3 _ChannelMixerBlue;
    float3 _Lift;
    float3 _InvGamma;
    float3 _Gain;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_Curves [[ sampler (0) ]],
    texture2d<half, access::sample > _Curves [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    float2 u_xlat4;
    bool u_xlatb4;
    float3 u_xlat5;
    float2 u_xlat10;
    float2 u_xlat11;
    float u_xlat12;
    bool u_xlatb12;
    u_xlat0.yz = input.TEXCOORD0.xy + (-FGlobals._Lut2D_Params.yz);
    u_xlat1.x = u_xlat0.y * FGlobals._Lut2D_Params.x;
    u_xlat0.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat0.x / FGlobals._Lut2D_Params.x;
    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
    u_xlat0.xyz = fma(u_xlat0.xzw, FGlobals._Lut2D_Params.www, float3(-0.413588405, -0.413588405, -0.413588405));
    u_xlat0.xyz = fma(u_xlat0.xyz, FGlobals._HueSatCon.xyzx.zzz, float3(0.0275523961, 0.0275523961, 0.0275523961));
    u_xlat0.xyz = u_xlat0.xyz * float3(13.6054821, 13.6054821, 13.6054821);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + float3(-0.0479959995, -0.0479959995, -0.0479959995);
    u_xlat0.xyz = u_xlat0.xyz * float3(0.179999992, 0.179999992, 0.179999992);
    u_xlat1.x = dot(float3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
    u_xlat1.y = dot(float3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
    u_xlat1.z = dot(float3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorBalance.xyzx.xyz;
    u_xlat1.x = dot(float3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
    u_xlat1.y = dot(float3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
    u_xlat1.z = dot(float3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorFilter.xyzx.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, FGlobals._ChannelMixerRed.xyzx.xyz);
    u_xlat1.y = dot(u_xlat0.xyz, FGlobals._ChannelMixerGreen.xyzx.xyz);
    u_xlat1.z = dot(u_xlat0.xyz, FGlobals._ChannelMixerBlue.xyzx.xyz);
    u_xlat0.xyz = fma(u_xlat1.xyz, FGlobals._Gain.xyzx.xyz, FGlobals._Lift.xyzx.xyz);
    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38), float3(0.5, 0.5, 0.5));
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(2.0, 2.0, 2.0), float3(-1.0, -1.0, -1.0));
    u_xlat1.xyz = u_xlat1.xyz * FGlobals._InvGamma.xyzx.xyz;
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlatb12 = u_xlat0.y>=u_xlat0.z;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat1.xy = u_xlat0.zy;
    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
    u_xlat1.z = float(-1.0);
    u_xlat1.w = float(0.666666687);
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(-1.0);
    u_xlat1 = fma(float4(u_xlat12), u_xlat2.xywz, u_xlat1.xywz);
    u_xlatb12 = u_xlat0.x>=u_xlat1.x;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat2.z = u_xlat1.w;
    u_xlat1.w = u_xlat0.x;
    u_xlat3.x = dot(u_xlat0.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat2.xyw = u_xlat1.wyx;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = fma(float4(u_xlat12), u_xlat2, u_xlat1);
    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
    u_xlat5.x = fma(u_xlat1.x, 6.0, 9.99999975e-05);
    u_xlat4.x = (-u_xlat0.y) + u_xlat0.w;
    u_xlat4.x = u_xlat4.x / u_xlat5.x;
    u_xlat4.x = u_xlat4.x + u_xlat0.z;
    u_xlat2.x = abs(u_xlat4.x);
    u_xlat11.x = u_xlat2.x + FGlobals._HueSatCon.xyzx.x;
    u_xlat3.y = float(0.25);
    u_xlat11.y = float(0.25);
    u_xlat4.x = float(_Curves.sample(sampler_Curves, u_xlat11.xy, level(0.0)).x);
    u_xlat4.y = float(_Curves.sample(sampler_Curves, u_xlat3.xy, level(0.0)).w);
    u_xlat4.xy = u_xlat4.xy;
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
    u_xlat4.x = u_xlat11.x + u_xlat4.x;
    u_xlat5.xyz = u_xlat4.xxx + float3(-0.5, 0.5, -1.5);
    u_xlatb4 = 1.0<u_xlat5.x;
    u_xlat4.x = (u_xlatb4) ? u_xlat5.z : u_xlat5.x;
    u_xlatb12 = u_xlat5.x<0.0;
    u_xlat4.x = (u_xlatb12) ? u_xlat5.y : u_xlat4.x;
    u_xlat5.xyz = u_xlat4.xxx + float3(1.0, 0.666666687, 0.333333343);
    u_xlat5.xyz = fract(u_xlat5.xyz);
    u_xlat5.xyz = fma(u_xlat5.xyz, float3(6.0, 6.0, 6.0), float3(-3.0, -3.0, -3.0));
    u_xlat5.xyz = abs(u_xlat5.xyz) + float3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0f, 1.0f);
    u_xlat5.xyz = u_xlat5.xyz + float3(-1.0, -1.0, -1.0);
    u_xlat4.x = u_xlat0.x + 9.99999975e-05;
    u_xlat10.x = u_xlat1.x / u_xlat4.x;
    u_xlat1.xyz = fma(u_xlat10.xxx, u_xlat5.xyz, float3(1.0, 1.0, 1.0));
    u_xlat3.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat1.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, (-u_xlat4.xxx));
    u_xlat2.y = float(0.25);
    u_xlat10.y = float(0.25);
    u_xlat0.x = float(_Curves.sample(sampler_Curves, u_xlat2.xy, level(0.0)).y);
    u_xlat0.w = float(_Curves.sample(sampler_Curves, u_xlat10.xy, level(0.0)).z);
    u_xlat0.xw = u_xlat0.xw;
    u_xlat0.xw = clamp(u_xlat0.xw, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = dot(u_xlat0.ww, u_xlat0.xx);
    u_xlat0.x = u_xlat0.x * u_xlat4.y;
    u_xlat0.x = dot(FGlobals._HueSatCon.xyzx.yy, u_xlat0.xx);
    u_xlat0.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, u_xlat4.xxx);
    output.SV_Target0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
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
    float4 _Lut2D_Params;
    float3 _ColorBalance;
    float3 _ColorFilter;
    float3 _HueSatCon;
    float3 _ChannelMixerRed;
    float3 _ChannelMixerGreen;
    float3 _ChannelMixerBlue;
    float3 _Lift;
    float3 _InvGamma;
    float3 _Gain;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_Curves [[ sampler (0) ]],
    texture2d<half, access::sample > _Curves [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    float2 u_xlat4;
    bool u_xlatb4;
    float3 u_xlat5;
    float2 u_xlat10;
    float2 u_xlat11;
    float u_xlat12;
    bool u_xlatb12;
    u_xlat0.yz = input.TEXCOORD0.xy + (-FGlobals._Lut2D_Params.yz);
    u_xlat1.x = u_xlat0.y * FGlobals._Lut2D_Params.x;
    u_xlat0.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat0.x / FGlobals._Lut2D_Params.x;
    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
    u_xlat0.xyz = fma(u_xlat0.xzw, FGlobals._Lut2D_Params.www, float3(-0.413588405, -0.413588405, -0.413588405));
    u_xlat0.xyz = fma(u_xlat0.xyz, FGlobals._HueSatCon.xyzx.zzz, float3(0.0275523961, 0.0275523961, 0.0275523961));
    u_xlat0.xyz = u_xlat0.xyz * float3(13.6054821, 13.6054821, 13.6054821);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + float3(-0.0479959995, -0.0479959995, -0.0479959995);
    u_xlat0.xyz = u_xlat0.xyz * float3(0.179999992, 0.179999992, 0.179999992);
    u_xlat1.x = dot(float3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
    u_xlat1.y = dot(float3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
    u_xlat1.z = dot(float3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorBalance.xyzx.xyz;
    u_xlat1.x = dot(float3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
    u_xlat1.y = dot(float3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
    u_xlat1.z = dot(float3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorFilter.xyzx.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, FGlobals._ChannelMixerRed.xyzx.xyz);
    u_xlat1.y = dot(u_xlat0.xyz, FGlobals._ChannelMixerGreen.xyzx.xyz);
    u_xlat1.z = dot(u_xlat0.xyz, FGlobals._ChannelMixerBlue.xyzx.xyz);
    u_xlat0.xyz = fma(u_xlat1.xyz, FGlobals._Gain.xyzx.xyz, FGlobals._Lift.xyzx.xyz);
    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38), float3(0.5, 0.5, 0.5));
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(2.0, 2.0, 2.0), float3(-1.0, -1.0, -1.0));
    u_xlat1.xyz = u_xlat1.xyz * FGlobals._InvGamma.xyzx.xyz;
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlatb12 = u_xlat0.y>=u_xlat0.z;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat1.xy = u_xlat0.zy;
    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
    u_xlat1.z = float(-1.0);
    u_xlat1.w = float(0.666666687);
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(-1.0);
    u_xlat1 = fma(float4(u_xlat12), u_xlat2.xywz, u_xlat1.xywz);
    u_xlatb12 = u_xlat0.x>=u_xlat1.x;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat2.z = u_xlat1.w;
    u_xlat1.w = u_xlat0.x;
    u_xlat3.x = dot(u_xlat0.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat2.xyw = u_xlat1.wyx;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = fma(float4(u_xlat12), u_xlat2, u_xlat1);
    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
    u_xlat5.x = fma(u_xlat1.x, 6.0, 9.99999975e-05);
    u_xlat4.x = (-u_xlat0.y) + u_xlat0.w;
    u_xlat4.x = u_xlat4.x / u_xlat5.x;
    u_xlat4.x = u_xlat4.x + u_xlat0.z;
    u_xlat2.x = abs(u_xlat4.x);
    u_xlat11.x = u_xlat2.x + FGlobals._HueSatCon.xyzx.x;
    u_xlat3.y = float(0.25);
    u_xlat11.y = float(0.25);
    u_xlat4.x = float(_Curves.sample(sampler_Curves, u_xlat11.xy, level(0.0)).x);
    u_xlat4.y = float(_Curves.sample(sampler_Curves, u_xlat3.xy, level(0.0)).w);
    u_xlat4.xy = u_xlat4.xy;
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
    u_xlat4.x = u_xlat11.x + u_xlat4.x;
    u_xlat5.xyz = u_xlat4.xxx + float3(-0.5, 0.5, -1.5);
    u_xlatb4 = 1.0<u_xlat5.x;
    u_xlat4.x = (u_xlatb4) ? u_xlat5.z : u_xlat5.x;
    u_xlatb12 = u_xlat5.x<0.0;
    u_xlat4.x = (u_xlatb12) ? u_xlat5.y : u_xlat4.x;
    u_xlat5.xyz = u_xlat4.xxx + float3(1.0, 0.666666687, 0.333333343);
    u_xlat5.xyz = fract(u_xlat5.xyz);
    u_xlat5.xyz = fma(u_xlat5.xyz, float3(6.0, 6.0, 6.0), float3(-3.0, -3.0, -3.0));
    u_xlat5.xyz = abs(u_xlat5.xyz) + float3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0f, 1.0f);
    u_xlat5.xyz = u_xlat5.xyz + float3(-1.0, -1.0, -1.0);
    u_xlat4.x = u_xlat0.x + 9.99999975e-05;
    u_xlat10.x = u_xlat1.x / u_xlat4.x;
    u_xlat1.xyz = fma(u_xlat10.xxx, u_xlat5.xyz, float3(1.0, 1.0, 1.0));
    u_xlat3.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat1.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, (-u_xlat4.xxx));
    u_xlat2.y = float(0.25);
    u_xlat10.y = float(0.25);
    u_xlat0.x = float(_Curves.sample(sampler_Curves, u_xlat2.xy, level(0.0)).y);
    u_xlat0.w = float(_Curves.sample(sampler_Curves, u_xlat10.xy, level(0.0)).z);
    u_xlat0.xw = u_xlat0.xw;
    u_xlat0.xw = clamp(u_xlat0.xw, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = dot(u_xlat0.ww, u_xlat0.xx);
    u_xlat0.x = u_xlat0.x * u_xlat4.y;
    u_xlat0.x = dot(FGlobals._HueSatCon.xyzx.yy, u_xlat0.xx);
    u_xlat0.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, u_xlat4.xxx);
    output.SV_Target0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
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
    float4 _Lut2D_Params;
    float3 _ColorBalance;
    float3 _ColorFilter;
    float3 _HueSatCon;
    float3 _ChannelMixerRed;
    float3 _ChannelMixerGreen;
    float3 _ChannelMixerBlue;
    float3 _Lift;
    float3 _InvGamma;
    float3 _Gain;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_Curves [[ sampler (0) ]],
    texture2d<half, access::sample > _Curves [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    float2 u_xlat4;
    bool u_xlatb4;
    float3 u_xlat5;
    float2 u_xlat10;
    float2 u_xlat11;
    float u_xlat12;
    bool u_xlatb12;
    u_xlat0.yz = input.TEXCOORD0.xy + (-FGlobals._Lut2D_Params.yz);
    u_xlat1.x = u_xlat0.y * FGlobals._Lut2D_Params.x;
    u_xlat0.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat0.x / FGlobals._Lut2D_Params.x;
    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
    u_xlat0.xyz = fma(u_xlat0.xzw, FGlobals._Lut2D_Params.www, float3(-0.413588405, -0.413588405, -0.413588405));
    u_xlat0.xyz = fma(u_xlat0.xyz, FGlobals._HueSatCon.xyzx.zzz, float3(0.0275523961, 0.0275523961, 0.0275523961));
    u_xlat0.xyz = u_xlat0.xyz * float3(13.6054821, 13.6054821, 13.6054821);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + float3(-0.0479959995, -0.0479959995, -0.0479959995);
    u_xlat0.xyz = u_xlat0.xyz * float3(0.179999992, 0.179999992, 0.179999992);
    u_xlat1.x = dot(float3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
    u_xlat1.y = dot(float3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
    u_xlat1.z = dot(float3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorBalance.xyzx.xyz;
    u_xlat1.x = dot(float3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
    u_xlat1.y = dot(float3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
    u_xlat1.z = dot(float3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorFilter.xyzx.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, FGlobals._ChannelMixerRed.xyzx.xyz);
    u_xlat1.y = dot(u_xlat0.xyz, FGlobals._ChannelMixerGreen.xyzx.xyz);
    u_xlat1.z = dot(u_xlat0.xyz, FGlobals._ChannelMixerBlue.xyzx.xyz);
    u_xlat0.xyz = fma(u_xlat1.xyz, FGlobals._Gain.xyzx.xyz, FGlobals._Lift.xyzx.xyz);
    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38), float3(0.5, 0.5, 0.5));
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(2.0, 2.0, 2.0), float3(-1.0, -1.0, -1.0));
    u_xlat1.xyz = u_xlat1.xyz * FGlobals._InvGamma.xyzx.xyz;
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlatb12 = u_xlat0.y>=u_xlat0.z;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat1.xy = u_xlat0.zy;
    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
    u_xlat1.z = float(-1.0);
    u_xlat1.w = float(0.666666687);
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(-1.0);
    u_xlat1 = fma(float4(u_xlat12), u_xlat2.xywz, u_xlat1.xywz);
    u_xlatb12 = u_xlat0.x>=u_xlat1.x;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat2.z = u_xlat1.w;
    u_xlat1.w = u_xlat0.x;
    u_xlat3.x = dot(u_xlat0.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat2.xyw = u_xlat1.wyx;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = fma(float4(u_xlat12), u_xlat2, u_xlat1);
    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
    u_xlat5.x = fma(u_xlat1.x, 6.0, 9.99999975e-05);
    u_xlat4.x = (-u_xlat0.y) + u_xlat0.w;
    u_xlat4.x = u_xlat4.x / u_xlat5.x;
    u_xlat4.x = u_xlat4.x + u_xlat0.z;
    u_xlat2.x = abs(u_xlat4.x);
    u_xlat11.x = u_xlat2.x + FGlobals._HueSatCon.xyzx.x;
    u_xlat3.y = float(0.25);
    u_xlat11.y = float(0.25);
    u_xlat4.x = float(_Curves.sample(sampler_Curves, u_xlat11.xy, level(0.0)).x);
    u_xlat4.y = float(_Curves.sample(sampler_Curves, u_xlat3.xy, level(0.0)).w);
    u_xlat4.xy = u_xlat4.xy;
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
    u_xlat4.x = u_xlat11.x + u_xlat4.x;
    u_xlat5.xyz = u_xlat4.xxx + float3(-0.5, 0.5, -1.5);
    u_xlatb4 = 1.0<u_xlat5.x;
    u_xlat4.x = (u_xlatb4) ? u_xlat5.z : u_xlat5.x;
    u_xlatb12 = u_xlat5.x<0.0;
    u_xlat4.x = (u_xlatb12) ? u_xlat5.y : u_xlat4.x;
    u_xlat5.xyz = u_xlat4.xxx + float3(1.0, 0.666666687, 0.333333343);
    u_xlat5.xyz = fract(u_xlat5.xyz);
    u_xlat5.xyz = fma(u_xlat5.xyz, float3(6.0, 6.0, 6.0), float3(-3.0, -3.0, -3.0));
    u_xlat5.xyz = abs(u_xlat5.xyz) + float3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0f, 1.0f);
    u_xlat5.xyz = u_xlat5.xyz + float3(-1.0, -1.0, -1.0);
    u_xlat4.x = u_xlat0.x + 9.99999975e-05;
    u_xlat10.x = u_xlat1.x / u_xlat4.x;
    u_xlat1.xyz = fma(u_xlat10.xxx, u_xlat5.xyz, float3(1.0, 1.0, 1.0));
    u_xlat3.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat1.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, (-u_xlat4.xxx));
    u_xlat2.y = float(0.25);
    u_xlat10.y = float(0.25);
    u_xlat0.x = float(_Curves.sample(sampler_Curves, u_xlat2.xy, level(0.0)).y);
    u_xlat0.w = float(_Curves.sample(sampler_Curves, u_xlat10.xy, level(0.0)).z);
    u_xlat0.xw = u_xlat0.xw;
    u_xlat0.xw = clamp(u_xlat0.xw, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = dot(u_xlat0.ww, u_xlat0.xx);
    u_xlat0.x = u_xlat0.x * u_xlat4.y;
    u_xlat0.x = dot(FGlobals._HueSatCon.xyzx.yy, u_xlat0.xx);
    u_xlat0.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, u_xlat4.xxx);
    output.SV_Target0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    output.SV_Target0.w = 1.0;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "TONEMAPPING_ACES" }
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
    float4 _Lut2D_Params;
    float3 _ColorBalance;
    float3 _ColorFilter;
    float3 _HueSatCon;
    float3 _ChannelMixerRed;
    float3 _ChannelMixerGreen;
    float3 _ChannelMixerBlue;
    float3 _Lift;
    float3 _InvGamma;
    float3 _Gain;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_Curves [[ sampler (0) ]],
    texture2d<half, access::sample > _Curves [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    bool3 u_xlatb0;
    float4 u_xlat1;
    bool4 u_xlatb1;
    float4 u_xlat2;
    bool2 u_xlatb2;
    float3 u_xlat3;
    float3 u_xlat4;
    bool u_xlatb4;
    float3 u_xlat5;
    bool u_xlatb5;
    float u_xlat8;
    float u_xlat9;
    float2 u_xlat10;
    float2 u_xlat11;
    float u_xlat12;
    bool u_xlatb12;
    bool u_xlatb13;
    u_xlat0.yz = input.TEXCOORD0.xy + (-FGlobals._Lut2D_Params.yz);
    u_xlat1.x = u_xlat0.y * FGlobals._Lut2D_Params.x;
    u_xlat0.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat0.x / FGlobals._Lut2D_Params.x;
    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
    u_xlat0.xyz = fma(u_xlat0.xzw, FGlobals._Lut2D_Params.www, float3(-0.386036009, -0.386036009, -0.386036009));
    u_xlat0.xyz = u_xlat0.xyz * float3(13.6054821, 13.6054821, 13.6054821);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + float3(-0.0479959995, -0.0479959995, -0.0479959995);
    u_xlat0.xyz = u_xlat0.xyz * float3(0.179999992, 0.179999992, 0.179999992);
    u_xlat1.x = dot(float3(0.439700991, 0.382977992, 0.177334994), u_xlat0.xyz);
    u_xlat1.y = dot(float3(0.0897922963, 0.813422978, 0.0967615992), u_xlat0.xyz);
    u_xlat1.z = dot(float3(0.0175439995, 0.111543998, 0.870703995), u_xlat0.xyz);
    u_xlat0.xyz = max(u_xlat1.xyz, float3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, float3(65504.0, 65504.0, 65504.0));
    u_xlat1.xyz = fma(u_xlat0.xyz, float3(0.5, 0.5, 0.5), float3(1.525878e-05, 1.525878e-05, 1.525878e-05));
    u_xlat1.xyz = log2(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz + float3(9.72000027, 9.72000027, 9.72000027);
    u_xlat1.xyz = u_xlat1.xyz * float3(0.0570776239, 0.0570776239, 0.0570776239);
    u_xlat2.xyz = log2(u_xlat0.xyz);
    u_xlatb0.xyz = (u_xlat0.xyz<float3(3.05175708e-05, 3.05175708e-05, 3.05175708e-05));
    u_xlat2.xyz = u_xlat2.xyz + float3(9.72000027, 9.72000027, 9.72000027);
    u_xlat2.xyz = u_xlat2.xyz * float3(0.0570776239, 0.0570776239, 0.0570776239);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat2.x;
    u_xlat0.y = (u_xlatb0.y) ? u_xlat1.y : u_xlat2.y;
    u_xlat0.z = (u_xlatb0.z) ? u_xlat1.z : u_xlat2.z;
    u_xlat0.xyz = u_xlat0.xyz + float3(-0.413588405, -0.413588405, -0.413588405);
    u_xlat0.xyz = fma(u_xlat0.xyz, FGlobals._HueSatCon.xyzx.zzz, float3(0.413588405, 0.413588405, 0.413588405));
    u_xlatb1 = (u_xlat0.xxyy<float4(-0.301369876, 1.46799636, -0.301369876, 1.46799636));
    u_xlat0.xyw = fma(u_xlat0.xyz, float3(17.5200005, 17.5200005, 17.5200005), float3(-9.72000027, -9.72000027, -9.72000027));
    u_xlatb2.xy = (u_xlat0.zz<float2(-0.301369876, 1.46799636));
    u_xlat0.xyz = exp2(u_xlat0.xyw);
    u_xlat5.x = (u_xlatb1.y) ? u_xlat0.x : float(65504.0);
    u_xlat5.z = (u_xlatb1.w) ? u_xlat0.y : float(65504.0);
    u_xlat0.xyw = u_xlat0.xyz + float3(-1.52587891e-05, -1.52587891e-05, -1.52587891e-05);
    u_xlat8 = (u_xlatb2.y) ? u_xlat0.z : 65504.0;
    u_xlat0.xyw = u_xlat0.xyw + u_xlat0.xyw;
    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat5.x;
    u_xlat1.y = (u_xlatb1.z) ? u_xlat0.y : u_xlat5.z;
    u_xlat1.z = (u_xlatb2.x) ? u_xlat0.w : u_xlat8;
    u_xlat0.x = dot(float3(1.45143926, -0.236510754, -0.214928567), u_xlat1.xyz);
    u_xlat0.y = dot(float3(-0.0765537769, 1.17622972, -0.0996759236), u_xlat1.xyz);
    u_xlat0.z = dot(float3(0.00831614807, -0.00603244966, 0.997716308), u_xlat1.xyz);
    u_xlat1.x = dot(float3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
    u_xlat1.y = dot(float3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
    u_xlat1.z = dot(float3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorBalance.xyzx.xyz;
    u_xlat1.x = dot(float3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
    u_xlat1.y = dot(float3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
    u_xlat1.z = dot(float3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorFilter.xyzx.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, FGlobals._ChannelMixerRed.xyzx.xyz);
    u_xlat1.y = dot(u_xlat0.xyz, FGlobals._ChannelMixerGreen.xyzx.xyz);
    u_xlat1.z = dot(u_xlat0.xyz, FGlobals._ChannelMixerBlue.xyzx.xyz);
    u_xlat0.xyz = fma(u_xlat1.xyz, FGlobals._Gain.xyzx.xyz, FGlobals._Lift.xyzx.xyz);
    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38), float3(0.5, 0.5, 0.5));
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(2.0, 2.0, 2.0), float3(-1.0, -1.0, -1.0));
    u_xlat1.xyz = u_xlat1.xyz * FGlobals._InvGamma.xyzx.xyz;
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlatb12 = u_xlat0.y>=u_xlat0.z;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat1.xy = u_xlat0.zy;
    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
    u_xlat1.z = float(-1.0);
    u_xlat1.w = float(0.666666687);
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(-1.0);
    u_xlat1 = fma(float4(u_xlat12), u_xlat2.xywz, u_xlat1.xywz);
    u_xlatb12 = u_xlat0.x>=u_xlat1.x;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat2.z = u_xlat1.w;
    u_xlat1.w = u_xlat0.x;
    u_xlat3.x = dot(u_xlat0.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat2.xyw = u_xlat1.wyx;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = fma(float4(u_xlat12), u_xlat2, u_xlat1);
    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
    u_xlat5.x = fma(u_xlat1.x, 6.0, 9.99999975e-05);
    u_xlat4.x = (-u_xlat0.y) + u_xlat0.w;
    u_xlat4.x = u_xlat4.x / u_xlat5.x;
    u_xlat4.x = u_xlat4.x + u_xlat0.z;
    u_xlat2.x = abs(u_xlat4.x);
    u_xlat11.x = u_xlat2.x + FGlobals._HueSatCon.xyzx.x;
    u_xlat3.y = float(0.25);
    u_xlat11.y = float(0.25);
    u_xlat4.x = float(_Curves.sample(sampler_Curves, u_xlat11.xy, level(0.0)).x);
    u_xlat4.y = float(_Curves.sample(sampler_Curves, u_xlat3.xy, level(0.0)).w);
    u_xlat4.xy = u_xlat4.xy;
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
    u_xlat4.x = u_xlat4.x + -0.5;
    u_xlat4.x = u_xlat4.x + u_xlat11.x;
    u_xlatb12 = 1.0<u_xlat4.x;
    u_xlat5.xy = u_xlat4.xx + float2(1.0, -1.0);
    u_xlat12 = (u_xlatb12) ? u_xlat5.y : u_xlat4.x;
    u_xlatb4 = u_xlat4.x<0.0;
    u_xlat4.x = (u_xlatb4) ? u_xlat5.x : u_xlat12;
    u_xlat5.xyz = u_xlat4.xxx + float3(1.0, 0.666666687, 0.333333343);
    u_xlat5.xyz = fract(u_xlat5.xyz);
    u_xlat5.xyz = fma(u_xlat5.xyz, float3(6.0, 6.0, 6.0), float3(-3.0, -3.0, -3.0));
    u_xlat5.xyz = abs(u_xlat5.xyz) + float3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0f, 1.0f);
    u_xlat5.xyz = u_xlat5.xyz + float3(-1.0, -1.0, -1.0);
    u_xlat4.x = u_xlat0.x + 9.99999975e-05;
    u_xlat10.x = u_xlat1.x / u_xlat4.x;
    u_xlat1.xyz = fma(u_xlat10.xxx, u_xlat5.xyz, float3(1.0, 1.0, 1.0));
    u_xlat3.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat1.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, (-u_xlat4.xxx));
    u_xlat2.y = float(0.25);
    u_xlat10.y = float(0.25);
    u_xlat0.x = float(_Curves.sample(sampler_Curves, u_xlat2.xy, level(0.0)).y);
    u_xlat0.w = float(_Curves.sample(sampler_Curves, u_xlat10.xy, level(0.0)).z);
    u_xlat0.xw = u_xlat0.xw;
    u_xlat0.xw = clamp(u_xlat0.xw, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = dot(u_xlat0.ww, u_xlat0.xx);
    u_xlat0.x = u_xlat0.x * u_xlat4.y;
    u_xlat0.x = dot(FGlobals._HueSatCon.xyzx.yy, u_xlat0.xx);
    u_xlat0.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, u_xlat4.xxx);
    u_xlat5.x = dot(float3(0.695452213, 0.140678704, 0.163869068), u_xlat0.xyz);
    u_xlat5.y = dot(float3(0.0447945632, 0.859671116, 0.0955343172), u_xlat0.xyz);
    u_xlat5.z = dot(float3(-0.00552588282, 0.00402521016, 1.00150073), u_xlat0.xyz);
    u_xlat0.xyz = (-u_xlat5.yxz) + u_xlat5.zyx;
    u_xlat0.xy = u_xlat0.xy * u_xlat5.zy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = fma(u_xlat5.x, u_xlat0.z, u_xlat0.x);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat4.x = u_xlat5.y + u_xlat5.z;
    u_xlat4.x = u_xlat5.x + u_xlat4.x;
    u_xlat0.x = fma(u_xlat0.x, 1.75, u_xlat4.x);
    u_xlat4.x = u_xlat0.x * 0.333333343;
    u_xlat4.x = 0.0799999982 / u_xlat4.x;
    u_xlat8 = min(u_xlat5.y, u_xlat5.x);
    u_xlat8 = min(u_xlat5.z, u_xlat8);
    u_xlat8 = max(u_xlat8, 9.99999975e-05);
    u_xlat12 = max(u_xlat5.y, u_xlat5.x);
    u_xlat12 = max(u_xlat5.z, u_xlat12);
    u_xlat2.xy = max(float2(u_xlat12), float2(9.99999975e-05, 0.00999999978));
    u_xlat8 = (-u_xlat8) + u_xlat2.x;
    u_xlat4.y = u_xlat8 / u_xlat2.y;
    u_xlat4.xz = u_xlat4.xy + float2(-0.5, -0.400000006);
    u_xlat1.x = u_xlat4.z * 2.5;
    u_xlat12 = fma(u_xlat4.z, as_type<float>(int(0x7f800000u)), 0.5);
    u_xlat12 = clamp(u_xlat12, 0.0f, 1.0f);
    u_xlat12 = fma(u_xlat12, 2.0, -1.0);
    u_xlat1.x = -abs(u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = fma((-u_xlat1.x), u_xlat1.x, 1.0);
    u_xlat12 = fma(u_xlat12, u_xlat1.x, 1.0);
    u_xlat12 = u_xlat12 * 0.0250000004;
    u_xlat4.x = u_xlat4.x * u_xlat12;
    u_xlatb1.x = u_xlat0.x>=0.479999989;
    u_xlatb0.x = 0.159999996>=u_xlat0.x;
    u_xlat4.x = (u_xlatb1.x) ? 0.0 : u_xlat4.x;
    u_xlat0.x = (u_xlatb0.x) ? u_xlat12 : u_xlat4.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat2.yzw = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat4.x = fma((-u_xlat5.x), u_xlat0.x, 0.0299999993);
    u_xlat12 = fma(u_xlat5.y, u_xlat0.x, (-u_xlat2.w));
    u_xlat12 = u_xlat12 * 1.73205078;
    u_xlat1.x = fma(u_xlat2.y, 2.0, (-u_xlat2.z));
    u_xlat0.x = fma((-u_xlat5.z), u_xlat0.x, u_xlat1.x);
    u_xlat1.x = max(abs(u_xlat0.x), abs(u_xlat12));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat5.x = min(abs(u_xlat0.x), abs(u_xlat12));
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlat5.x = u_xlat1.x * u_xlat1.x;
    u_xlat9 = fma(u_xlat5.x, 0.0208350997, -0.0851330012);
    u_xlat9 = fma(u_xlat5.x, u_xlat9, 0.180141002);
    u_xlat9 = fma(u_xlat5.x, u_xlat9, -0.330299497);
    u_xlat5.x = fma(u_xlat5.x, u_xlat9, 0.999866009);
    u_xlat9 = u_xlat5.x * u_xlat1.x;
    u_xlat9 = fma(u_xlat9, -2.0, 1.57079637);
    u_xlatb13 = abs(u_xlat0.x)<abs(u_xlat12);
    u_xlat9 = u_xlatb13 ? u_xlat9 : float(0.0);
    u_xlat1.x = fma(u_xlat1.x, u_xlat5.x, u_xlat9);
    u_xlatb5 = u_xlat0.x<(-u_xlat0.x);
    u_xlat5.x = u_xlatb5 ? -3.14159274 : float(0.0);
    u_xlat1.x = u_xlat5.x + u_xlat1.x;
    u_xlat5.x = min(u_xlat0.x, u_xlat12);
    u_xlat0.x = max(u_xlat0.x, u_xlat12);
    u_xlatb0.x = u_xlat0.x>=(-u_xlat0.x);
    u_xlatb12 = u_xlat5.x<(-u_xlat5.x);
    u_xlatb0.x = u_xlatb0.x && u_xlatb12;
    u_xlat0.x = (u_xlatb0.x) ? (-u_xlat1.x) : u_xlat1.x;
    u_xlat0.x = u_xlat0.x * 57.2957802;
    u_xlatb1.xy = (u_xlat2.zw==u_xlat2.yz);
    u_xlatb12 = u_xlatb1.y && u_xlatb1.x;
    u_xlat0.x = (u_xlatb12) ? 0.0 : u_xlat0.x;
    u_xlatb12 = u_xlat0.x<0.0;
    u_xlat1.x = u_xlat0.x + 360.0;
    u_xlat0.x = (u_xlatb12) ? u_xlat1.x : u_xlat0.x;
    u_xlatb12 = 180.0<u_xlat0.x;
    u_xlat1.xy = u_xlat0.xx + float2(360.0, -360.0);
    u_xlat12 = (u_xlatb12) ? u_xlat1.y : u_xlat0.x;
    u_xlatb0.x = u_xlat0.x<-180.0;
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat12;
    u_xlat0.x = u_xlat0.x * 0.0148148146;
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat12 = fma(u_xlat0.x, -2.0, 3.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat4.y * u_xlat0.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlat2.x = fma(u_xlat0.x, 0.180000007, u_xlat2.y);
    u_xlat0.x = dot(float3(1.45143926, -0.236510754, -0.214928567), u_xlat2.xzw);
    u_xlat0.y = dot(float3(-0.0765537769, 1.17622972, -0.0996759236), u_xlat2.xzw);
    u_xlat0.z = dot(float3(0.00831614807, -0.00603244966, 0.997716308), u_xlat2.xzw);
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlat12 = dot(u_xlat0.xyz, float3(0.272228986, 0.674081981, 0.0536894985));
    u_xlat0.xyz = (-float3(u_xlat12)) + u_xlat0.xyz;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(0.959999979, 0.959999979, 0.959999979), float3(u_xlat12));
    u_xlat1.xyz = fma(u_xlat0.xyz, float3(278.508514, 278.508514, 278.508514), float3(10.7771997, 10.7771997, 10.7771997));
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = fma(u_xlat0.xyz, float3(293.604492, 293.604492, 293.604492), float3(88.7121964, 88.7121964, 88.7121964));
    u_xlat0.xyz = fma(u_xlat0.xyz, u_xlat2.xyz, float3(80.6889038, 80.6889038, 80.6889038));
    u_xlat0.xyz = u_xlat1.xyz / u_xlat0.xyz;
    u_xlat1.z = dot(float3(-0.00557464967, 0.0040607336, 1.01033914), u_xlat0.xyz);
    u_xlat1.x = dot(float3(0.662454188, 0.134004205, 0.156187683), u_xlat0.xyz);
    u_xlat1.y = dot(float3(0.272228718, 0.674081743, 0.0536895171), u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, float3(1.0, 1.0, 1.0));
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.xy = u_xlat1.xy / u_xlat0.xx;
    u_xlat12 = max(u_xlat1.y, 0.0);
    u_xlat12 = min(u_xlat12, 65504.0);
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * 0.981100023;
    u_xlat1.y = exp2(u_xlat12);
    u_xlat12 = (-u_xlat0.x) + 1.0;
    u_xlat0.z = (-u_xlat0.y) + u_xlat12;
    u_xlat4.x = max(u_xlat0.y, 9.99999975e-05);
    u_xlat4.x = u_xlat1.y / u_xlat4.x;
    u_xlat1.xz = u_xlat4.xx * u_xlat0.xz;
    u_xlat0.x = dot(float3(1.6410234, -0.324803293, -0.236424699), u_xlat1.xyz);
    u_xlat0.y = dot(float3(-0.663662851, 1.61533165, 0.0167563483), u_xlat1.xyz);
    u_xlat0.z = dot(float3(0.0117218941, -0.00828444213, 0.988394856), u_xlat1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, float3(0.272228986, 0.674081981, 0.0536894985));
    u_xlat0.xyz = (-float3(u_xlat12)) + u_xlat0.xyz;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(0.930000007, 0.930000007, 0.930000007), float3(u_xlat12));
    u_xlat1.x = dot(float3(0.662454188, 0.134004205, 0.156187683), u_xlat0.xyz);
    u_xlat1.y = dot(float3(0.272228718, 0.674081743, 0.0536895171), u_xlat0.xyz);
    u_xlat1.z = dot(float3(-0.00557464967, 0.0040607336, 1.01033914), u_xlat0.xyz);
    u_xlat0.x = dot(float3(0.987223983, -0.00611326983, 0.0159533005), u_xlat1.xyz);
    u_xlat0.y = dot(float3(-0.00759836007, 1.00186002, 0.00533019984), u_xlat1.xyz);
    u_xlat0.z = dot(float3(0.00307257008, -0.00509594986, 1.08168006), u_xlat1.xyz);
    u_xlat1.x = dot(float3(3.2409699, -1.5373832, -0.498610765), u_xlat0.xyz);
    u_xlat1.y = dot(float3(-0.969243646, 1.8759675, 0.0415550582), u_xlat0.xyz);
    u_xlat1.z = dot(float3(0.0556300804, -0.203976959, 1.05697155), u_xlat0.xyz);
    output.SV_Target0.xyz = max(u_xlat1.xyz, float3(0.0, 0.0, 0.0));
    output.SV_Target0.w = 1.0;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "TONEMAPPING_ACES" }
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
    float4 _Lut2D_Params;
    float3 _ColorBalance;
    float3 _ColorFilter;
    float3 _HueSatCon;
    float3 _ChannelMixerRed;
    float3 _ChannelMixerGreen;
    float3 _ChannelMixerBlue;
    float3 _Lift;
    float3 _InvGamma;
    float3 _Gain;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_Curves [[ sampler (0) ]],
    texture2d<half, access::sample > _Curves [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    bool3 u_xlatb0;
    float4 u_xlat1;
    bool4 u_xlatb1;
    float4 u_xlat2;
    bool2 u_xlatb2;
    float3 u_xlat3;
    float3 u_xlat4;
    bool u_xlatb4;
    float3 u_xlat5;
    bool u_xlatb5;
    float u_xlat8;
    float u_xlat9;
    float2 u_xlat10;
    float2 u_xlat11;
    float u_xlat12;
    bool u_xlatb12;
    bool u_xlatb13;
    u_xlat0.yz = input.TEXCOORD0.xy + (-FGlobals._Lut2D_Params.yz);
    u_xlat1.x = u_xlat0.y * FGlobals._Lut2D_Params.x;
    u_xlat0.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat0.x / FGlobals._Lut2D_Params.x;
    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
    u_xlat0.xyz = fma(u_xlat0.xzw, FGlobals._Lut2D_Params.www, float3(-0.386036009, -0.386036009, -0.386036009));
    u_xlat0.xyz = u_xlat0.xyz * float3(13.6054821, 13.6054821, 13.6054821);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + float3(-0.0479959995, -0.0479959995, -0.0479959995);
    u_xlat0.xyz = u_xlat0.xyz * float3(0.179999992, 0.179999992, 0.179999992);
    u_xlat1.x = dot(float3(0.439700991, 0.382977992, 0.177334994), u_xlat0.xyz);
    u_xlat1.y = dot(float3(0.0897922963, 0.813422978, 0.0967615992), u_xlat0.xyz);
    u_xlat1.z = dot(float3(0.0175439995, 0.111543998, 0.870703995), u_xlat0.xyz);
    u_xlat0.xyz = max(u_xlat1.xyz, float3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, float3(65504.0, 65504.0, 65504.0));
    u_xlat1.xyz = fma(u_xlat0.xyz, float3(0.5, 0.5, 0.5), float3(1.525878e-05, 1.525878e-05, 1.525878e-05));
    u_xlat1.xyz = log2(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz + float3(9.72000027, 9.72000027, 9.72000027);
    u_xlat1.xyz = u_xlat1.xyz * float3(0.0570776239, 0.0570776239, 0.0570776239);
    u_xlat2.xyz = log2(u_xlat0.xyz);
    u_xlatb0.xyz = (u_xlat0.xyz<float3(3.05175708e-05, 3.05175708e-05, 3.05175708e-05));
    u_xlat2.xyz = u_xlat2.xyz + float3(9.72000027, 9.72000027, 9.72000027);
    u_xlat2.xyz = u_xlat2.xyz * float3(0.0570776239, 0.0570776239, 0.0570776239);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat2.x;
    u_xlat0.y = (u_xlatb0.y) ? u_xlat1.y : u_xlat2.y;
    u_xlat0.z = (u_xlatb0.z) ? u_xlat1.z : u_xlat2.z;
    u_xlat0.xyz = u_xlat0.xyz + float3(-0.413588405, -0.413588405, -0.413588405);
    u_xlat0.xyz = fma(u_xlat0.xyz, FGlobals._HueSatCon.xyzx.zzz, float3(0.413588405, 0.413588405, 0.413588405));
    u_xlatb1 = (u_xlat0.xxyy<float4(-0.301369876, 1.46799636, -0.301369876, 1.46799636));
    u_xlat0.xyw = fma(u_xlat0.xyz, float3(17.5200005, 17.5200005, 17.5200005), float3(-9.72000027, -9.72000027, -9.72000027));
    u_xlatb2.xy = (u_xlat0.zz<float2(-0.301369876, 1.46799636));
    u_xlat0.xyz = exp2(u_xlat0.xyw);
    u_xlat5.x = (u_xlatb1.y) ? u_xlat0.x : float(65504.0);
    u_xlat5.z = (u_xlatb1.w) ? u_xlat0.y : float(65504.0);
    u_xlat0.xyw = u_xlat0.xyz + float3(-1.52587891e-05, -1.52587891e-05, -1.52587891e-05);
    u_xlat8 = (u_xlatb2.y) ? u_xlat0.z : 65504.0;
    u_xlat0.xyw = u_xlat0.xyw + u_xlat0.xyw;
    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat5.x;
    u_xlat1.y = (u_xlatb1.z) ? u_xlat0.y : u_xlat5.z;
    u_xlat1.z = (u_xlatb2.x) ? u_xlat0.w : u_xlat8;
    u_xlat0.x = dot(float3(1.45143926, -0.236510754, -0.214928567), u_xlat1.xyz);
    u_xlat0.y = dot(float3(-0.0765537769, 1.17622972, -0.0996759236), u_xlat1.xyz);
    u_xlat0.z = dot(float3(0.00831614807, -0.00603244966, 0.997716308), u_xlat1.xyz);
    u_xlat1.x = dot(float3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
    u_xlat1.y = dot(float3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
    u_xlat1.z = dot(float3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorBalance.xyzx.xyz;
    u_xlat1.x = dot(float3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
    u_xlat1.y = dot(float3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
    u_xlat1.z = dot(float3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorFilter.xyzx.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, FGlobals._ChannelMixerRed.xyzx.xyz);
    u_xlat1.y = dot(u_xlat0.xyz, FGlobals._ChannelMixerGreen.xyzx.xyz);
    u_xlat1.z = dot(u_xlat0.xyz, FGlobals._ChannelMixerBlue.xyzx.xyz);
    u_xlat0.xyz = fma(u_xlat1.xyz, FGlobals._Gain.xyzx.xyz, FGlobals._Lift.xyzx.xyz);
    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38), float3(0.5, 0.5, 0.5));
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(2.0, 2.0, 2.0), float3(-1.0, -1.0, -1.0));
    u_xlat1.xyz = u_xlat1.xyz * FGlobals._InvGamma.xyzx.xyz;
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlatb12 = u_xlat0.y>=u_xlat0.z;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat1.xy = u_xlat0.zy;
    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
    u_xlat1.z = float(-1.0);
    u_xlat1.w = float(0.666666687);
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(-1.0);
    u_xlat1 = fma(float4(u_xlat12), u_xlat2.xywz, u_xlat1.xywz);
    u_xlatb12 = u_xlat0.x>=u_xlat1.x;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat2.z = u_xlat1.w;
    u_xlat1.w = u_xlat0.x;
    u_xlat3.x = dot(u_xlat0.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat2.xyw = u_xlat1.wyx;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = fma(float4(u_xlat12), u_xlat2, u_xlat1);
    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
    u_xlat5.x = fma(u_xlat1.x, 6.0, 9.99999975e-05);
    u_xlat4.x = (-u_xlat0.y) + u_xlat0.w;
    u_xlat4.x = u_xlat4.x / u_xlat5.x;
    u_xlat4.x = u_xlat4.x + u_xlat0.z;
    u_xlat2.x = abs(u_xlat4.x);
    u_xlat11.x = u_xlat2.x + FGlobals._HueSatCon.xyzx.x;
    u_xlat3.y = float(0.25);
    u_xlat11.y = float(0.25);
    u_xlat4.x = float(_Curves.sample(sampler_Curves, u_xlat11.xy, level(0.0)).x);
    u_xlat4.y = float(_Curves.sample(sampler_Curves, u_xlat3.xy, level(0.0)).w);
    u_xlat4.xy = u_xlat4.xy;
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
    u_xlat4.x = u_xlat4.x + -0.5;
    u_xlat4.x = u_xlat4.x + u_xlat11.x;
    u_xlatb12 = 1.0<u_xlat4.x;
    u_xlat5.xy = u_xlat4.xx + float2(1.0, -1.0);
    u_xlat12 = (u_xlatb12) ? u_xlat5.y : u_xlat4.x;
    u_xlatb4 = u_xlat4.x<0.0;
    u_xlat4.x = (u_xlatb4) ? u_xlat5.x : u_xlat12;
    u_xlat5.xyz = u_xlat4.xxx + float3(1.0, 0.666666687, 0.333333343);
    u_xlat5.xyz = fract(u_xlat5.xyz);
    u_xlat5.xyz = fma(u_xlat5.xyz, float3(6.0, 6.0, 6.0), float3(-3.0, -3.0, -3.0));
    u_xlat5.xyz = abs(u_xlat5.xyz) + float3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0f, 1.0f);
    u_xlat5.xyz = u_xlat5.xyz + float3(-1.0, -1.0, -1.0);
    u_xlat4.x = u_xlat0.x + 9.99999975e-05;
    u_xlat10.x = u_xlat1.x / u_xlat4.x;
    u_xlat1.xyz = fma(u_xlat10.xxx, u_xlat5.xyz, float3(1.0, 1.0, 1.0));
    u_xlat3.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat1.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, (-u_xlat4.xxx));
    u_xlat2.y = float(0.25);
    u_xlat10.y = float(0.25);
    u_xlat0.x = float(_Curves.sample(sampler_Curves, u_xlat2.xy, level(0.0)).y);
    u_xlat0.w = float(_Curves.sample(sampler_Curves, u_xlat10.xy, level(0.0)).z);
    u_xlat0.xw = u_xlat0.xw;
    u_xlat0.xw = clamp(u_xlat0.xw, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = dot(u_xlat0.ww, u_xlat0.xx);
    u_xlat0.x = u_xlat0.x * u_xlat4.y;
    u_xlat0.x = dot(FGlobals._HueSatCon.xyzx.yy, u_xlat0.xx);
    u_xlat0.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, u_xlat4.xxx);
    u_xlat5.x = dot(float3(0.695452213, 0.140678704, 0.163869068), u_xlat0.xyz);
    u_xlat5.y = dot(float3(0.0447945632, 0.859671116, 0.0955343172), u_xlat0.xyz);
    u_xlat5.z = dot(float3(-0.00552588282, 0.00402521016, 1.00150073), u_xlat0.xyz);
    u_xlat0.xyz = (-u_xlat5.yxz) + u_xlat5.zyx;
    u_xlat0.xy = u_xlat0.xy * u_xlat5.zy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = fma(u_xlat5.x, u_xlat0.z, u_xlat0.x);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat4.x = u_xlat5.y + u_xlat5.z;
    u_xlat4.x = u_xlat5.x + u_xlat4.x;
    u_xlat0.x = fma(u_xlat0.x, 1.75, u_xlat4.x);
    u_xlat4.x = u_xlat0.x * 0.333333343;
    u_xlat4.x = 0.0799999982 / u_xlat4.x;
    u_xlat8 = min(u_xlat5.y, u_xlat5.x);
    u_xlat8 = min(u_xlat5.z, u_xlat8);
    u_xlat8 = max(u_xlat8, 9.99999975e-05);
    u_xlat12 = max(u_xlat5.y, u_xlat5.x);
    u_xlat12 = max(u_xlat5.z, u_xlat12);
    u_xlat2.xy = max(float2(u_xlat12), float2(9.99999975e-05, 0.00999999978));
    u_xlat8 = (-u_xlat8) + u_xlat2.x;
    u_xlat4.y = u_xlat8 / u_xlat2.y;
    u_xlat4.xz = u_xlat4.xy + float2(-0.5, -0.400000006);
    u_xlat1.x = u_xlat4.z * 2.5;
    u_xlat12 = fma(u_xlat4.z, as_type<float>(int(0x7f800000u)), 0.5);
    u_xlat12 = clamp(u_xlat12, 0.0f, 1.0f);
    u_xlat12 = fma(u_xlat12, 2.0, -1.0);
    u_xlat1.x = -abs(u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = fma((-u_xlat1.x), u_xlat1.x, 1.0);
    u_xlat12 = fma(u_xlat12, u_xlat1.x, 1.0);
    u_xlat12 = u_xlat12 * 0.0250000004;
    u_xlat4.x = u_xlat4.x * u_xlat12;
    u_xlatb1.x = u_xlat0.x>=0.479999989;
    u_xlatb0.x = 0.159999996>=u_xlat0.x;
    u_xlat4.x = (u_xlatb1.x) ? 0.0 : u_xlat4.x;
    u_xlat0.x = (u_xlatb0.x) ? u_xlat12 : u_xlat4.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat2.yzw = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat4.x = fma((-u_xlat5.x), u_xlat0.x, 0.0299999993);
    u_xlat12 = fma(u_xlat5.y, u_xlat0.x, (-u_xlat2.w));
    u_xlat12 = u_xlat12 * 1.73205078;
    u_xlat1.x = fma(u_xlat2.y, 2.0, (-u_xlat2.z));
    u_xlat0.x = fma((-u_xlat5.z), u_xlat0.x, u_xlat1.x);
    u_xlat1.x = max(abs(u_xlat0.x), abs(u_xlat12));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat5.x = min(abs(u_xlat0.x), abs(u_xlat12));
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlat5.x = u_xlat1.x * u_xlat1.x;
    u_xlat9 = fma(u_xlat5.x, 0.0208350997, -0.0851330012);
    u_xlat9 = fma(u_xlat5.x, u_xlat9, 0.180141002);
    u_xlat9 = fma(u_xlat5.x, u_xlat9, -0.330299497);
    u_xlat5.x = fma(u_xlat5.x, u_xlat9, 0.999866009);
    u_xlat9 = u_xlat5.x * u_xlat1.x;
    u_xlat9 = fma(u_xlat9, -2.0, 1.57079637);
    u_xlatb13 = abs(u_xlat0.x)<abs(u_xlat12);
    u_xlat9 = u_xlatb13 ? u_xlat9 : float(0.0);
    u_xlat1.x = fma(u_xlat1.x, u_xlat5.x, u_xlat9);
    u_xlatb5 = u_xlat0.x<(-u_xlat0.x);
    u_xlat5.x = u_xlatb5 ? -3.14159274 : float(0.0);
    u_xlat1.x = u_xlat5.x + u_xlat1.x;
    u_xlat5.x = min(u_xlat0.x, u_xlat12);
    u_xlat0.x = max(u_xlat0.x, u_xlat12);
    u_xlatb0.x = u_xlat0.x>=(-u_xlat0.x);
    u_xlatb12 = u_xlat5.x<(-u_xlat5.x);
    u_xlatb0.x = u_xlatb0.x && u_xlatb12;
    u_xlat0.x = (u_xlatb0.x) ? (-u_xlat1.x) : u_xlat1.x;
    u_xlat0.x = u_xlat0.x * 57.2957802;
    u_xlatb1.xy = (u_xlat2.zw==u_xlat2.yz);
    u_xlatb12 = u_xlatb1.y && u_xlatb1.x;
    u_xlat0.x = (u_xlatb12) ? 0.0 : u_xlat0.x;
    u_xlatb12 = u_xlat0.x<0.0;
    u_xlat1.x = u_xlat0.x + 360.0;
    u_xlat0.x = (u_xlatb12) ? u_xlat1.x : u_xlat0.x;
    u_xlatb12 = 180.0<u_xlat0.x;
    u_xlat1.xy = u_xlat0.xx + float2(360.0, -360.0);
    u_xlat12 = (u_xlatb12) ? u_xlat1.y : u_xlat0.x;
    u_xlatb0.x = u_xlat0.x<-180.0;
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat12;
    u_xlat0.x = u_xlat0.x * 0.0148148146;
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat12 = fma(u_xlat0.x, -2.0, 3.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat4.y * u_xlat0.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlat2.x = fma(u_xlat0.x, 0.180000007, u_xlat2.y);
    u_xlat0.x = dot(float3(1.45143926, -0.236510754, -0.214928567), u_xlat2.xzw);
    u_xlat0.y = dot(float3(-0.0765537769, 1.17622972, -0.0996759236), u_xlat2.xzw);
    u_xlat0.z = dot(float3(0.00831614807, -0.00603244966, 0.997716308), u_xlat2.xzw);
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlat12 = dot(u_xlat0.xyz, float3(0.272228986, 0.674081981, 0.0536894985));
    u_xlat0.xyz = (-float3(u_xlat12)) + u_xlat0.xyz;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(0.959999979, 0.959999979, 0.959999979), float3(u_xlat12));
    u_xlat1.xyz = fma(u_xlat0.xyz, float3(278.508514, 278.508514, 278.508514), float3(10.7771997, 10.7771997, 10.7771997));
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = fma(u_xlat0.xyz, float3(293.604492, 293.604492, 293.604492), float3(88.7121964, 88.7121964, 88.7121964));
    u_xlat0.xyz = fma(u_xlat0.xyz, u_xlat2.xyz, float3(80.6889038, 80.6889038, 80.6889038));
    u_xlat0.xyz = u_xlat1.xyz / u_xlat0.xyz;
    u_xlat1.z = dot(float3(-0.00557464967, 0.0040607336, 1.01033914), u_xlat0.xyz);
    u_xlat1.x = dot(float3(0.662454188, 0.134004205, 0.156187683), u_xlat0.xyz);
    u_xlat1.y = dot(float3(0.272228718, 0.674081743, 0.0536895171), u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, float3(1.0, 1.0, 1.0));
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.xy = u_xlat1.xy / u_xlat0.xx;
    u_xlat12 = max(u_xlat1.y, 0.0);
    u_xlat12 = min(u_xlat12, 65504.0);
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * 0.981100023;
    u_xlat1.y = exp2(u_xlat12);
    u_xlat12 = (-u_xlat0.x) + 1.0;
    u_xlat0.z = (-u_xlat0.y) + u_xlat12;
    u_xlat4.x = max(u_xlat0.y, 9.99999975e-05);
    u_xlat4.x = u_xlat1.y / u_xlat4.x;
    u_xlat1.xz = u_xlat4.xx * u_xlat0.xz;
    u_xlat0.x = dot(float3(1.6410234, -0.324803293, -0.236424699), u_xlat1.xyz);
    u_xlat0.y = dot(float3(-0.663662851, 1.61533165, 0.0167563483), u_xlat1.xyz);
    u_xlat0.z = dot(float3(0.0117218941, -0.00828444213, 0.988394856), u_xlat1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, float3(0.272228986, 0.674081981, 0.0536894985));
    u_xlat0.xyz = (-float3(u_xlat12)) + u_xlat0.xyz;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(0.930000007, 0.930000007, 0.930000007), float3(u_xlat12));
    u_xlat1.x = dot(float3(0.662454188, 0.134004205, 0.156187683), u_xlat0.xyz);
    u_xlat1.y = dot(float3(0.272228718, 0.674081743, 0.0536895171), u_xlat0.xyz);
    u_xlat1.z = dot(float3(-0.00557464967, 0.0040607336, 1.01033914), u_xlat0.xyz);
    u_xlat0.x = dot(float3(0.987223983, -0.00611326983, 0.0159533005), u_xlat1.xyz);
    u_xlat0.y = dot(float3(-0.00759836007, 1.00186002, 0.00533019984), u_xlat1.xyz);
    u_xlat0.z = dot(float3(0.00307257008, -0.00509594986, 1.08168006), u_xlat1.xyz);
    u_xlat1.x = dot(float3(3.2409699, -1.5373832, -0.498610765), u_xlat0.xyz);
    u_xlat1.y = dot(float3(-0.969243646, 1.8759675, 0.0415550582), u_xlat0.xyz);
    u_xlat1.z = dot(float3(0.0556300804, -0.203976959, 1.05697155), u_xlat0.xyz);
    output.SV_Target0.xyz = max(u_xlat1.xyz, float3(0.0, 0.0, 0.0));
    output.SV_Target0.w = 1.0;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "TONEMAPPING_ACES" }
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
    float4 _Lut2D_Params;
    float3 _ColorBalance;
    float3 _ColorFilter;
    float3 _HueSatCon;
    float3 _ChannelMixerRed;
    float3 _ChannelMixerGreen;
    float3 _ChannelMixerBlue;
    float3 _Lift;
    float3 _InvGamma;
    float3 _Gain;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_Curves [[ sampler (0) ]],
    texture2d<half, access::sample > _Curves [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    bool3 u_xlatb0;
    float4 u_xlat1;
    bool4 u_xlatb1;
    float4 u_xlat2;
    bool2 u_xlatb2;
    float3 u_xlat3;
    float3 u_xlat4;
    bool u_xlatb4;
    float3 u_xlat5;
    bool u_xlatb5;
    float u_xlat8;
    float u_xlat9;
    float2 u_xlat10;
    float2 u_xlat11;
    float u_xlat12;
    bool u_xlatb12;
    bool u_xlatb13;
    u_xlat0.yz = input.TEXCOORD0.xy + (-FGlobals._Lut2D_Params.yz);
    u_xlat1.x = u_xlat0.y * FGlobals._Lut2D_Params.x;
    u_xlat0.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat0.x / FGlobals._Lut2D_Params.x;
    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
    u_xlat0.xyz = fma(u_xlat0.xzw, FGlobals._Lut2D_Params.www, float3(-0.386036009, -0.386036009, -0.386036009));
    u_xlat0.xyz = u_xlat0.xyz * float3(13.6054821, 13.6054821, 13.6054821);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + float3(-0.0479959995, -0.0479959995, -0.0479959995);
    u_xlat0.xyz = u_xlat0.xyz * float3(0.179999992, 0.179999992, 0.179999992);
    u_xlat1.x = dot(float3(0.439700991, 0.382977992, 0.177334994), u_xlat0.xyz);
    u_xlat1.y = dot(float3(0.0897922963, 0.813422978, 0.0967615992), u_xlat0.xyz);
    u_xlat1.z = dot(float3(0.0175439995, 0.111543998, 0.870703995), u_xlat0.xyz);
    u_xlat0.xyz = max(u_xlat1.xyz, float3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, float3(65504.0, 65504.0, 65504.0));
    u_xlat1.xyz = fma(u_xlat0.xyz, float3(0.5, 0.5, 0.5), float3(1.525878e-05, 1.525878e-05, 1.525878e-05));
    u_xlat1.xyz = log2(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz + float3(9.72000027, 9.72000027, 9.72000027);
    u_xlat1.xyz = u_xlat1.xyz * float3(0.0570776239, 0.0570776239, 0.0570776239);
    u_xlat2.xyz = log2(u_xlat0.xyz);
    u_xlatb0.xyz = (u_xlat0.xyz<float3(3.05175708e-05, 3.05175708e-05, 3.05175708e-05));
    u_xlat2.xyz = u_xlat2.xyz + float3(9.72000027, 9.72000027, 9.72000027);
    u_xlat2.xyz = u_xlat2.xyz * float3(0.0570776239, 0.0570776239, 0.0570776239);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat2.x;
    u_xlat0.y = (u_xlatb0.y) ? u_xlat1.y : u_xlat2.y;
    u_xlat0.z = (u_xlatb0.z) ? u_xlat1.z : u_xlat2.z;
    u_xlat0.xyz = u_xlat0.xyz + float3(-0.413588405, -0.413588405, -0.413588405);
    u_xlat0.xyz = fma(u_xlat0.xyz, FGlobals._HueSatCon.xyzx.zzz, float3(0.413588405, 0.413588405, 0.413588405));
    u_xlatb1 = (u_xlat0.xxyy<float4(-0.301369876, 1.46799636, -0.301369876, 1.46799636));
    u_xlat0.xyw = fma(u_xlat0.xyz, float3(17.5200005, 17.5200005, 17.5200005), float3(-9.72000027, -9.72000027, -9.72000027));
    u_xlatb2.xy = (u_xlat0.zz<float2(-0.301369876, 1.46799636));
    u_xlat0.xyz = exp2(u_xlat0.xyw);
    u_xlat5.x = (u_xlatb1.y) ? u_xlat0.x : float(65504.0);
    u_xlat5.z = (u_xlatb1.w) ? u_xlat0.y : float(65504.0);
    u_xlat0.xyw = u_xlat0.xyz + float3(-1.52587891e-05, -1.52587891e-05, -1.52587891e-05);
    u_xlat8 = (u_xlatb2.y) ? u_xlat0.z : 65504.0;
    u_xlat0.xyw = u_xlat0.xyw + u_xlat0.xyw;
    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat5.x;
    u_xlat1.y = (u_xlatb1.z) ? u_xlat0.y : u_xlat5.z;
    u_xlat1.z = (u_xlatb2.x) ? u_xlat0.w : u_xlat8;
    u_xlat0.x = dot(float3(1.45143926, -0.236510754, -0.214928567), u_xlat1.xyz);
    u_xlat0.y = dot(float3(-0.0765537769, 1.17622972, -0.0996759236), u_xlat1.xyz);
    u_xlat0.z = dot(float3(0.00831614807, -0.00603244966, 0.997716308), u_xlat1.xyz);
    u_xlat1.x = dot(float3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
    u_xlat1.y = dot(float3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
    u_xlat1.z = dot(float3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorBalance.xyzx.xyz;
    u_xlat1.x = dot(float3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
    u_xlat1.y = dot(float3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
    u_xlat1.z = dot(float3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorFilter.xyzx.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, FGlobals._ChannelMixerRed.xyzx.xyz);
    u_xlat1.y = dot(u_xlat0.xyz, FGlobals._ChannelMixerGreen.xyzx.xyz);
    u_xlat1.z = dot(u_xlat0.xyz, FGlobals._ChannelMixerBlue.xyzx.xyz);
    u_xlat0.xyz = fma(u_xlat1.xyz, FGlobals._Gain.xyzx.xyz, FGlobals._Lift.xyzx.xyz);
    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38), float3(0.5, 0.5, 0.5));
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(2.0, 2.0, 2.0), float3(-1.0, -1.0, -1.0));
    u_xlat1.xyz = u_xlat1.xyz * FGlobals._InvGamma.xyzx.xyz;
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlatb12 = u_xlat0.y>=u_xlat0.z;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat1.xy = u_xlat0.zy;
    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
    u_xlat1.z = float(-1.0);
    u_xlat1.w = float(0.666666687);
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(-1.0);
    u_xlat1 = fma(float4(u_xlat12), u_xlat2.xywz, u_xlat1.xywz);
    u_xlatb12 = u_xlat0.x>=u_xlat1.x;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat2.z = u_xlat1.w;
    u_xlat1.w = u_xlat0.x;
    u_xlat3.x = dot(u_xlat0.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat2.xyw = u_xlat1.wyx;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = fma(float4(u_xlat12), u_xlat2, u_xlat1);
    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
    u_xlat5.x = fma(u_xlat1.x, 6.0, 9.99999975e-05);
    u_xlat4.x = (-u_xlat0.y) + u_xlat0.w;
    u_xlat4.x = u_xlat4.x / u_xlat5.x;
    u_xlat4.x = u_xlat4.x + u_xlat0.z;
    u_xlat2.x = abs(u_xlat4.x);
    u_xlat11.x = u_xlat2.x + FGlobals._HueSatCon.xyzx.x;
    u_xlat3.y = float(0.25);
    u_xlat11.y = float(0.25);
    u_xlat4.x = float(_Curves.sample(sampler_Curves, u_xlat11.xy, level(0.0)).x);
    u_xlat4.y = float(_Curves.sample(sampler_Curves, u_xlat3.xy, level(0.0)).w);
    u_xlat4.xy = u_xlat4.xy;
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
    u_xlat4.x = u_xlat4.x + -0.5;
    u_xlat4.x = u_xlat4.x + u_xlat11.x;
    u_xlatb12 = 1.0<u_xlat4.x;
    u_xlat5.xy = u_xlat4.xx + float2(1.0, -1.0);
    u_xlat12 = (u_xlatb12) ? u_xlat5.y : u_xlat4.x;
    u_xlatb4 = u_xlat4.x<0.0;
    u_xlat4.x = (u_xlatb4) ? u_xlat5.x : u_xlat12;
    u_xlat5.xyz = u_xlat4.xxx + float3(1.0, 0.666666687, 0.333333343);
    u_xlat5.xyz = fract(u_xlat5.xyz);
    u_xlat5.xyz = fma(u_xlat5.xyz, float3(6.0, 6.0, 6.0), float3(-3.0, -3.0, -3.0));
    u_xlat5.xyz = abs(u_xlat5.xyz) + float3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0f, 1.0f);
    u_xlat5.xyz = u_xlat5.xyz + float3(-1.0, -1.0, -1.0);
    u_xlat4.x = u_xlat0.x + 9.99999975e-05;
    u_xlat10.x = u_xlat1.x / u_xlat4.x;
    u_xlat1.xyz = fma(u_xlat10.xxx, u_xlat5.xyz, float3(1.0, 1.0, 1.0));
    u_xlat3.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat1.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, (-u_xlat4.xxx));
    u_xlat2.y = float(0.25);
    u_xlat10.y = float(0.25);
    u_xlat0.x = float(_Curves.sample(sampler_Curves, u_xlat2.xy, level(0.0)).y);
    u_xlat0.w = float(_Curves.sample(sampler_Curves, u_xlat10.xy, level(0.0)).z);
    u_xlat0.xw = u_xlat0.xw;
    u_xlat0.xw = clamp(u_xlat0.xw, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = dot(u_xlat0.ww, u_xlat0.xx);
    u_xlat0.x = u_xlat0.x * u_xlat4.y;
    u_xlat0.x = dot(FGlobals._HueSatCon.xyzx.yy, u_xlat0.xx);
    u_xlat0.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, u_xlat4.xxx);
    u_xlat5.x = dot(float3(0.695452213, 0.140678704, 0.163869068), u_xlat0.xyz);
    u_xlat5.y = dot(float3(0.0447945632, 0.859671116, 0.0955343172), u_xlat0.xyz);
    u_xlat5.z = dot(float3(-0.00552588282, 0.00402521016, 1.00150073), u_xlat0.xyz);
    u_xlat0.xyz = (-u_xlat5.yxz) + u_xlat5.zyx;
    u_xlat0.xy = u_xlat0.xy * u_xlat5.zy;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = fma(u_xlat5.x, u_xlat0.z, u_xlat0.x);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat4.x = u_xlat5.y + u_xlat5.z;
    u_xlat4.x = u_xlat5.x + u_xlat4.x;
    u_xlat0.x = fma(u_xlat0.x, 1.75, u_xlat4.x);
    u_xlat4.x = u_xlat0.x * 0.333333343;
    u_xlat4.x = 0.0799999982 / u_xlat4.x;
    u_xlat8 = min(u_xlat5.y, u_xlat5.x);
    u_xlat8 = min(u_xlat5.z, u_xlat8);
    u_xlat8 = max(u_xlat8, 9.99999975e-05);
    u_xlat12 = max(u_xlat5.y, u_xlat5.x);
    u_xlat12 = max(u_xlat5.z, u_xlat12);
    u_xlat2.xy = max(float2(u_xlat12), float2(9.99999975e-05, 0.00999999978));
    u_xlat8 = (-u_xlat8) + u_xlat2.x;
    u_xlat4.y = u_xlat8 / u_xlat2.y;
    u_xlat4.xz = u_xlat4.xy + float2(-0.5, -0.400000006);
    u_xlat1.x = u_xlat4.z * 2.5;
    u_xlat12 = fma(u_xlat4.z, as_type<float>(int(0x7f800000u)), 0.5);
    u_xlat12 = clamp(u_xlat12, 0.0f, 1.0f);
    u_xlat12 = fma(u_xlat12, 2.0, -1.0);
    u_xlat1.x = -abs(u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = fma((-u_xlat1.x), u_xlat1.x, 1.0);
    u_xlat12 = fma(u_xlat12, u_xlat1.x, 1.0);
    u_xlat12 = u_xlat12 * 0.0250000004;
    u_xlat4.x = u_xlat4.x * u_xlat12;
    u_xlatb1.x = u_xlat0.x>=0.479999989;
    u_xlatb0.x = 0.159999996>=u_xlat0.x;
    u_xlat4.x = (u_xlatb1.x) ? 0.0 : u_xlat4.x;
    u_xlat0.x = (u_xlatb0.x) ? u_xlat12 : u_xlat4.x;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat2.yzw = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat4.x = fma((-u_xlat5.x), u_xlat0.x, 0.0299999993);
    u_xlat12 = fma(u_xlat5.y, u_xlat0.x, (-u_xlat2.w));
    u_xlat12 = u_xlat12 * 1.73205078;
    u_xlat1.x = fma(u_xlat2.y, 2.0, (-u_xlat2.z));
    u_xlat0.x = fma((-u_xlat5.z), u_xlat0.x, u_xlat1.x);
    u_xlat1.x = max(abs(u_xlat0.x), abs(u_xlat12));
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat5.x = min(abs(u_xlat0.x), abs(u_xlat12));
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlat5.x = u_xlat1.x * u_xlat1.x;
    u_xlat9 = fma(u_xlat5.x, 0.0208350997, -0.0851330012);
    u_xlat9 = fma(u_xlat5.x, u_xlat9, 0.180141002);
    u_xlat9 = fma(u_xlat5.x, u_xlat9, -0.330299497);
    u_xlat5.x = fma(u_xlat5.x, u_xlat9, 0.999866009);
    u_xlat9 = u_xlat5.x * u_xlat1.x;
    u_xlat9 = fma(u_xlat9, -2.0, 1.57079637);
    u_xlatb13 = abs(u_xlat0.x)<abs(u_xlat12);
    u_xlat9 = u_xlatb13 ? u_xlat9 : float(0.0);
    u_xlat1.x = fma(u_xlat1.x, u_xlat5.x, u_xlat9);
    u_xlatb5 = u_xlat0.x<(-u_xlat0.x);
    u_xlat5.x = u_xlatb5 ? -3.14159274 : float(0.0);
    u_xlat1.x = u_xlat5.x + u_xlat1.x;
    u_xlat5.x = min(u_xlat0.x, u_xlat12);
    u_xlat0.x = max(u_xlat0.x, u_xlat12);
    u_xlatb0.x = u_xlat0.x>=(-u_xlat0.x);
    u_xlatb12 = u_xlat5.x<(-u_xlat5.x);
    u_xlatb0.x = u_xlatb0.x && u_xlatb12;
    u_xlat0.x = (u_xlatb0.x) ? (-u_xlat1.x) : u_xlat1.x;
    u_xlat0.x = u_xlat0.x * 57.2957802;
    u_xlatb1.xy = (u_xlat2.zw==u_xlat2.yz);
    u_xlatb12 = u_xlatb1.y && u_xlatb1.x;
    u_xlat0.x = (u_xlatb12) ? 0.0 : u_xlat0.x;
    u_xlatb12 = u_xlat0.x<0.0;
    u_xlat1.x = u_xlat0.x + 360.0;
    u_xlat0.x = (u_xlatb12) ? u_xlat1.x : u_xlat0.x;
    u_xlatb12 = 180.0<u_xlat0.x;
    u_xlat1.xy = u_xlat0.xx + float2(360.0, -360.0);
    u_xlat12 = (u_xlatb12) ? u_xlat1.y : u_xlat0.x;
    u_xlatb0.x = u_xlat0.x<-180.0;
    u_xlat0.x = (u_xlatb0.x) ? u_xlat1.x : u_xlat12;
    u_xlat0.x = u_xlat0.x * 0.0148148146;
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat12 = fma(u_xlat0.x, -2.0, 3.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat12;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat4.y * u_xlat0.x;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlat2.x = fma(u_xlat0.x, 0.180000007, u_xlat2.y);
    u_xlat0.x = dot(float3(1.45143926, -0.236510754, -0.214928567), u_xlat2.xzw);
    u_xlat0.y = dot(float3(-0.0765537769, 1.17622972, -0.0996759236), u_xlat2.xzw);
    u_xlat0.z = dot(float3(0.00831614807, -0.00603244966, 0.997716308), u_xlat2.xzw);
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlat12 = dot(u_xlat0.xyz, float3(0.272228986, 0.674081981, 0.0536894985));
    u_xlat0.xyz = (-float3(u_xlat12)) + u_xlat0.xyz;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(0.959999979, 0.959999979, 0.959999979), float3(u_xlat12));
    u_xlat1.xyz = fma(u_xlat0.xyz, float3(278.508514, 278.508514, 278.508514), float3(10.7771997, 10.7771997, 10.7771997));
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = fma(u_xlat0.xyz, float3(293.604492, 293.604492, 293.604492), float3(88.7121964, 88.7121964, 88.7121964));
    u_xlat0.xyz = fma(u_xlat0.xyz, u_xlat2.xyz, float3(80.6889038, 80.6889038, 80.6889038));
    u_xlat0.xyz = u_xlat1.xyz / u_xlat0.xyz;
    u_xlat1.z = dot(float3(-0.00557464967, 0.0040607336, 1.01033914), u_xlat0.xyz);
    u_xlat1.x = dot(float3(0.662454188, 0.134004205, 0.156187683), u_xlat0.xyz);
    u_xlat1.y = dot(float3(0.272228718, 0.674081743, 0.0536895171), u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, float3(1.0, 1.0, 1.0));
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.xy = u_xlat1.xy / u_xlat0.xx;
    u_xlat12 = max(u_xlat1.y, 0.0);
    u_xlat12 = min(u_xlat12, 65504.0);
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * 0.981100023;
    u_xlat1.y = exp2(u_xlat12);
    u_xlat12 = (-u_xlat0.x) + 1.0;
    u_xlat0.z = (-u_xlat0.y) + u_xlat12;
    u_xlat4.x = max(u_xlat0.y, 9.99999975e-05);
    u_xlat4.x = u_xlat1.y / u_xlat4.x;
    u_xlat1.xz = u_xlat4.xx * u_xlat0.xz;
    u_xlat0.x = dot(float3(1.6410234, -0.324803293, -0.236424699), u_xlat1.xyz);
    u_xlat0.y = dot(float3(-0.663662851, 1.61533165, 0.0167563483), u_xlat1.xyz);
    u_xlat0.z = dot(float3(0.0117218941, -0.00828444213, 0.988394856), u_xlat1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, float3(0.272228986, 0.674081981, 0.0536894985));
    u_xlat0.xyz = (-float3(u_xlat12)) + u_xlat0.xyz;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(0.930000007, 0.930000007, 0.930000007), float3(u_xlat12));
    u_xlat1.x = dot(float3(0.662454188, 0.134004205, 0.156187683), u_xlat0.xyz);
    u_xlat1.y = dot(float3(0.272228718, 0.674081743, 0.0536895171), u_xlat0.xyz);
    u_xlat1.z = dot(float3(-0.00557464967, 0.0040607336, 1.01033914), u_xlat0.xyz);
    u_xlat0.x = dot(float3(0.987223983, -0.00611326983, 0.0159533005), u_xlat1.xyz);
    u_xlat0.y = dot(float3(-0.00759836007, 1.00186002, 0.00533019984), u_xlat1.xyz);
    u_xlat0.z = dot(float3(0.00307257008, -0.00509594986, 1.08168006), u_xlat1.xyz);
    u_xlat1.x = dot(float3(3.2409699, -1.5373832, -0.498610765), u_xlat0.xyz);
    u_xlat1.y = dot(float3(-0.969243646, 1.8759675, 0.0415550582), u_xlat0.xyz);
    u_xlat1.z = dot(float3(0.0556300804, -0.203976959, 1.05697155), u_xlat0.xyz);
    output.SV_Target0.xyz = max(u_xlat1.xyz, float3(0.0, 0.0, 0.0));
    output.SV_Target0.w = 1.0;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "TONEMAPPING_NEUTRAL" }
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
    float4 _Lut2D_Params;
    float3 _ColorBalance;
    float3 _ColorFilter;
    float3 _HueSatCon;
    float3 _ChannelMixerRed;
    float3 _ChannelMixerGreen;
    float3 _ChannelMixerBlue;
    float3 _Lift;
    float3 _InvGamma;
    float3 _Gain;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_Curves [[ sampler (0) ]],
    texture2d<half, access::sample > _Curves [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    float2 u_xlat4;
    bool u_xlatb4;
    float3 u_xlat5;
    float2 u_xlat10;
    float2 u_xlat11;
    float u_xlat12;
    bool u_xlatb12;
    u_xlat0.yz = input.TEXCOORD0.xy + (-FGlobals._Lut2D_Params.yz);
    u_xlat1.x = u_xlat0.y * FGlobals._Lut2D_Params.x;
    u_xlat0.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat0.x / FGlobals._Lut2D_Params.x;
    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
    u_xlat0.xyz = fma(u_xlat0.xzw, FGlobals._Lut2D_Params.www, float3(-0.413588405, -0.413588405, -0.413588405));
    u_xlat0.xyz = fma(u_xlat0.xyz, FGlobals._HueSatCon.xyzx.zzz, float3(0.0275523961, 0.0275523961, 0.0275523961));
    u_xlat0.xyz = u_xlat0.xyz * float3(13.6054821, 13.6054821, 13.6054821);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + float3(-0.0479959995, -0.0479959995, -0.0479959995);
    u_xlat0.xyz = u_xlat0.xyz * float3(0.179999992, 0.179999992, 0.179999992);
    u_xlat1.x = dot(float3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
    u_xlat1.y = dot(float3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
    u_xlat1.z = dot(float3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorBalance.xyzx.xyz;
    u_xlat1.x = dot(float3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
    u_xlat1.y = dot(float3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
    u_xlat1.z = dot(float3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorFilter.xyzx.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, FGlobals._ChannelMixerRed.xyzx.xyz);
    u_xlat1.y = dot(u_xlat0.xyz, FGlobals._ChannelMixerGreen.xyzx.xyz);
    u_xlat1.z = dot(u_xlat0.xyz, FGlobals._ChannelMixerBlue.xyzx.xyz);
    u_xlat0.xyz = fma(u_xlat1.xyz, FGlobals._Gain.xyzx.xyz, FGlobals._Lift.xyzx.xyz);
    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38), float3(0.5, 0.5, 0.5));
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(2.0, 2.0, 2.0), float3(-1.0, -1.0, -1.0));
    u_xlat1.xyz = u_xlat1.xyz * FGlobals._InvGamma.xyzx.xyz;
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlatb12 = u_xlat0.y>=u_xlat0.z;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat1.xy = u_xlat0.zy;
    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
    u_xlat1.z = float(-1.0);
    u_xlat1.w = float(0.666666687);
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(-1.0);
    u_xlat1 = fma(float4(u_xlat12), u_xlat2.xywz, u_xlat1.xywz);
    u_xlatb12 = u_xlat0.x>=u_xlat1.x;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat2.z = u_xlat1.w;
    u_xlat1.w = u_xlat0.x;
    u_xlat3.x = dot(u_xlat0.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat2.xyw = u_xlat1.wyx;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = fma(float4(u_xlat12), u_xlat2, u_xlat1);
    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
    u_xlat5.x = fma(u_xlat1.x, 6.0, 9.99999975e-05);
    u_xlat4.x = (-u_xlat0.y) + u_xlat0.w;
    u_xlat4.x = u_xlat4.x / u_xlat5.x;
    u_xlat4.x = u_xlat4.x + u_xlat0.z;
    u_xlat2.x = abs(u_xlat4.x);
    u_xlat11.x = u_xlat2.x + FGlobals._HueSatCon.xyzx.x;
    u_xlat3.y = float(0.25);
    u_xlat11.y = float(0.25);
    u_xlat4.x = float(_Curves.sample(sampler_Curves, u_xlat11.xy, level(0.0)).x);
    u_xlat4.y = float(_Curves.sample(sampler_Curves, u_xlat3.xy, level(0.0)).w);
    u_xlat4.xy = u_xlat4.xy;
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
    u_xlat4.x = u_xlat11.x + u_xlat4.x;
    u_xlat5.xyz = u_xlat4.xxx + float3(-0.5, 0.5, -1.5);
    u_xlatb4 = 1.0<u_xlat5.x;
    u_xlat4.x = (u_xlatb4) ? u_xlat5.z : u_xlat5.x;
    u_xlatb12 = u_xlat5.x<0.0;
    u_xlat4.x = (u_xlatb12) ? u_xlat5.y : u_xlat4.x;
    u_xlat5.xyz = u_xlat4.xxx + float3(1.0, 0.666666687, 0.333333343);
    u_xlat5.xyz = fract(u_xlat5.xyz);
    u_xlat5.xyz = fma(u_xlat5.xyz, float3(6.0, 6.0, 6.0), float3(-3.0, -3.0, -3.0));
    u_xlat5.xyz = abs(u_xlat5.xyz) + float3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0f, 1.0f);
    u_xlat5.xyz = u_xlat5.xyz + float3(-1.0, -1.0, -1.0);
    u_xlat4.x = u_xlat0.x + 9.99999975e-05;
    u_xlat10.x = u_xlat1.x / u_xlat4.x;
    u_xlat1.xyz = fma(u_xlat10.xxx, u_xlat5.xyz, float3(1.0, 1.0, 1.0));
    u_xlat3.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat1.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, (-u_xlat4.xxx));
    u_xlat2.y = float(0.25);
    u_xlat10.y = float(0.25);
    u_xlat0.x = float(_Curves.sample(sampler_Curves, u_xlat2.xy, level(0.0)).y);
    u_xlat0.w = float(_Curves.sample(sampler_Curves, u_xlat10.xy, level(0.0)).z);
    u_xlat0.xw = u_xlat0.xw;
    u_xlat0.xw = clamp(u_xlat0.xw, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = dot(u_xlat0.ww, u_xlat0.xx);
    u_xlat0.x = u_xlat0.x * u_xlat4.y;
    u_xlat0.x = dot(FGlobals._HueSatCon.xyzx.yy, u_xlat0.xx);
    u_xlat0.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, u_xlat4.xxx);
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlat1.xyz = fma(u_xlat0.xyz, float3(0.262677222, 0.262677222, 0.262677222), float3(0.0695999935, 0.0695999935, 0.0695999935));
    u_xlat2.xyz = u_xlat0.xyz * float3(1.31338608, 1.31338608, 1.31338608);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(0.262677222, 0.262677222, 0.262677222), float3(0.289999992, 0.289999992, 0.289999992));
    u_xlat0.xyz = fma(u_xlat2.xyz, u_xlat0.xyz, float3(0.0816000104, 0.0816000104, 0.0816000104));
    u_xlat1.xyz = fma(u_xlat2.xyz, u_xlat1.xyz, float3(0.00543999998, 0.00543999998, 0.00543999998));
    u_xlat0.xyz = u_xlat1.xyz / u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + float3(-0.0666666627, -0.0666666627, -0.0666666627);
    u_xlat0.xyz = u_xlat0.xyz * float3(1.31338608, 1.31338608, 1.31338608);
    output.SV_Target0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    output.SV_Target0.w = 1.0;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "TONEMAPPING_NEUTRAL" }
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
    float4 _Lut2D_Params;
    float3 _ColorBalance;
    float3 _ColorFilter;
    float3 _HueSatCon;
    float3 _ChannelMixerRed;
    float3 _ChannelMixerGreen;
    float3 _ChannelMixerBlue;
    float3 _Lift;
    float3 _InvGamma;
    float3 _Gain;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_Curves [[ sampler (0) ]],
    texture2d<half, access::sample > _Curves [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    float2 u_xlat4;
    bool u_xlatb4;
    float3 u_xlat5;
    float2 u_xlat10;
    float2 u_xlat11;
    float u_xlat12;
    bool u_xlatb12;
    u_xlat0.yz = input.TEXCOORD0.xy + (-FGlobals._Lut2D_Params.yz);
    u_xlat1.x = u_xlat0.y * FGlobals._Lut2D_Params.x;
    u_xlat0.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat0.x / FGlobals._Lut2D_Params.x;
    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
    u_xlat0.xyz = fma(u_xlat0.xzw, FGlobals._Lut2D_Params.www, float3(-0.413588405, -0.413588405, -0.413588405));
    u_xlat0.xyz = fma(u_xlat0.xyz, FGlobals._HueSatCon.xyzx.zzz, float3(0.0275523961, 0.0275523961, 0.0275523961));
    u_xlat0.xyz = u_xlat0.xyz * float3(13.6054821, 13.6054821, 13.6054821);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + float3(-0.0479959995, -0.0479959995, -0.0479959995);
    u_xlat0.xyz = u_xlat0.xyz * float3(0.179999992, 0.179999992, 0.179999992);
    u_xlat1.x = dot(float3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
    u_xlat1.y = dot(float3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
    u_xlat1.z = dot(float3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorBalance.xyzx.xyz;
    u_xlat1.x = dot(float3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
    u_xlat1.y = dot(float3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
    u_xlat1.z = dot(float3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorFilter.xyzx.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, FGlobals._ChannelMixerRed.xyzx.xyz);
    u_xlat1.y = dot(u_xlat0.xyz, FGlobals._ChannelMixerGreen.xyzx.xyz);
    u_xlat1.z = dot(u_xlat0.xyz, FGlobals._ChannelMixerBlue.xyzx.xyz);
    u_xlat0.xyz = fma(u_xlat1.xyz, FGlobals._Gain.xyzx.xyz, FGlobals._Lift.xyzx.xyz);
    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38), float3(0.5, 0.5, 0.5));
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(2.0, 2.0, 2.0), float3(-1.0, -1.0, -1.0));
    u_xlat1.xyz = u_xlat1.xyz * FGlobals._InvGamma.xyzx.xyz;
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlatb12 = u_xlat0.y>=u_xlat0.z;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat1.xy = u_xlat0.zy;
    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
    u_xlat1.z = float(-1.0);
    u_xlat1.w = float(0.666666687);
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(-1.0);
    u_xlat1 = fma(float4(u_xlat12), u_xlat2.xywz, u_xlat1.xywz);
    u_xlatb12 = u_xlat0.x>=u_xlat1.x;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat2.z = u_xlat1.w;
    u_xlat1.w = u_xlat0.x;
    u_xlat3.x = dot(u_xlat0.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat2.xyw = u_xlat1.wyx;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = fma(float4(u_xlat12), u_xlat2, u_xlat1);
    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
    u_xlat5.x = fma(u_xlat1.x, 6.0, 9.99999975e-05);
    u_xlat4.x = (-u_xlat0.y) + u_xlat0.w;
    u_xlat4.x = u_xlat4.x / u_xlat5.x;
    u_xlat4.x = u_xlat4.x + u_xlat0.z;
    u_xlat2.x = abs(u_xlat4.x);
    u_xlat11.x = u_xlat2.x + FGlobals._HueSatCon.xyzx.x;
    u_xlat3.y = float(0.25);
    u_xlat11.y = float(0.25);
    u_xlat4.x = float(_Curves.sample(sampler_Curves, u_xlat11.xy, level(0.0)).x);
    u_xlat4.y = float(_Curves.sample(sampler_Curves, u_xlat3.xy, level(0.0)).w);
    u_xlat4.xy = u_xlat4.xy;
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
    u_xlat4.x = u_xlat11.x + u_xlat4.x;
    u_xlat5.xyz = u_xlat4.xxx + float3(-0.5, 0.5, -1.5);
    u_xlatb4 = 1.0<u_xlat5.x;
    u_xlat4.x = (u_xlatb4) ? u_xlat5.z : u_xlat5.x;
    u_xlatb12 = u_xlat5.x<0.0;
    u_xlat4.x = (u_xlatb12) ? u_xlat5.y : u_xlat4.x;
    u_xlat5.xyz = u_xlat4.xxx + float3(1.0, 0.666666687, 0.333333343);
    u_xlat5.xyz = fract(u_xlat5.xyz);
    u_xlat5.xyz = fma(u_xlat5.xyz, float3(6.0, 6.0, 6.0), float3(-3.0, -3.0, -3.0));
    u_xlat5.xyz = abs(u_xlat5.xyz) + float3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0f, 1.0f);
    u_xlat5.xyz = u_xlat5.xyz + float3(-1.0, -1.0, -1.0);
    u_xlat4.x = u_xlat0.x + 9.99999975e-05;
    u_xlat10.x = u_xlat1.x / u_xlat4.x;
    u_xlat1.xyz = fma(u_xlat10.xxx, u_xlat5.xyz, float3(1.0, 1.0, 1.0));
    u_xlat3.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat1.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, (-u_xlat4.xxx));
    u_xlat2.y = float(0.25);
    u_xlat10.y = float(0.25);
    u_xlat0.x = float(_Curves.sample(sampler_Curves, u_xlat2.xy, level(0.0)).y);
    u_xlat0.w = float(_Curves.sample(sampler_Curves, u_xlat10.xy, level(0.0)).z);
    u_xlat0.xw = u_xlat0.xw;
    u_xlat0.xw = clamp(u_xlat0.xw, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = dot(u_xlat0.ww, u_xlat0.xx);
    u_xlat0.x = u_xlat0.x * u_xlat4.y;
    u_xlat0.x = dot(FGlobals._HueSatCon.xyzx.yy, u_xlat0.xx);
    u_xlat0.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, u_xlat4.xxx);
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlat1.xyz = fma(u_xlat0.xyz, float3(0.262677222, 0.262677222, 0.262677222), float3(0.0695999935, 0.0695999935, 0.0695999935));
    u_xlat2.xyz = u_xlat0.xyz * float3(1.31338608, 1.31338608, 1.31338608);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(0.262677222, 0.262677222, 0.262677222), float3(0.289999992, 0.289999992, 0.289999992));
    u_xlat0.xyz = fma(u_xlat2.xyz, u_xlat0.xyz, float3(0.0816000104, 0.0816000104, 0.0816000104));
    u_xlat1.xyz = fma(u_xlat2.xyz, u_xlat1.xyz, float3(0.00543999998, 0.00543999998, 0.00543999998));
    u_xlat0.xyz = u_xlat1.xyz / u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + float3(-0.0666666627, -0.0666666627, -0.0666666627);
    u_xlat0.xyz = u_xlat0.xyz * float3(1.31338608, 1.31338608, 1.31338608);
    output.SV_Target0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    output.SV_Target0.w = 1.0;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "TONEMAPPING_NEUTRAL" }
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
    float4 _Lut2D_Params;
    float3 _ColorBalance;
    float3 _ColorFilter;
    float3 _HueSatCon;
    float3 _ChannelMixerRed;
    float3 _ChannelMixerGreen;
    float3 _ChannelMixerBlue;
    float3 _Lift;
    float3 _InvGamma;
    float3 _Gain;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_Curves [[ sampler (0) ]],
    texture2d<half, access::sample > _Curves [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    float2 u_xlat4;
    bool u_xlatb4;
    float3 u_xlat5;
    float2 u_xlat10;
    float2 u_xlat11;
    float u_xlat12;
    bool u_xlatb12;
    u_xlat0.yz = input.TEXCOORD0.xy + (-FGlobals._Lut2D_Params.yz);
    u_xlat1.x = u_xlat0.y * FGlobals._Lut2D_Params.x;
    u_xlat0.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat0.x / FGlobals._Lut2D_Params.x;
    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
    u_xlat0.xyz = fma(u_xlat0.xzw, FGlobals._Lut2D_Params.www, float3(-0.413588405, -0.413588405, -0.413588405));
    u_xlat0.xyz = fma(u_xlat0.xyz, FGlobals._HueSatCon.xyzx.zzz, float3(0.0275523961, 0.0275523961, 0.0275523961));
    u_xlat0.xyz = u_xlat0.xyz * float3(13.6054821, 13.6054821, 13.6054821);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + float3(-0.0479959995, -0.0479959995, -0.0479959995);
    u_xlat0.xyz = u_xlat0.xyz * float3(0.179999992, 0.179999992, 0.179999992);
    u_xlat1.x = dot(float3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
    u_xlat1.y = dot(float3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
    u_xlat1.z = dot(float3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorBalance.xyzx.xyz;
    u_xlat1.x = dot(float3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
    u_xlat1.y = dot(float3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
    u_xlat1.z = dot(float3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorFilter.xyzx.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, FGlobals._ChannelMixerRed.xyzx.xyz);
    u_xlat1.y = dot(u_xlat0.xyz, FGlobals._ChannelMixerGreen.xyzx.xyz);
    u_xlat1.z = dot(u_xlat0.xyz, FGlobals._ChannelMixerBlue.xyzx.xyz);
    u_xlat0.xyz = fma(u_xlat1.xyz, FGlobals._Gain.xyzx.xyz, FGlobals._Lift.xyzx.xyz);
    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38), float3(0.5, 0.5, 0.5));
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(2.0, 2.0, 2.0), float3(-1.0, -1.0, -1.0));
    u_xlat1.xyz = u_xlat1.xyz * FGlobals._InvGamma.xyzx.xyz;
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlatb12 = u_xlat0.y>=u_xlat0.z;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat1.xy = u_xlat0.zy;
    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
    u_xlat1.z = float(-1.0);
    u_xlat1.w = float(0.666666687);
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(-1.0);
    u_xlat1 = fma(float4(u_xlat12), u_xlat2.xywz, u_xlat1.xywz);
    u_xlatb12 = u_xlat0.x>=u_xlat1.x;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat2.z = u_xlat1.w;
    u_xlat1.w = u_xlat0.x;
    u_xlat3.x = dot(u_xlat0.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat2.xyw = u_xlat1.wyx;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = fma(float4(u_xlat12), u_xlat2, u_xlat1);
    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
    u_xlat5.x = fma(u_xlat1.x, 6.0, 9.99999975e-05);
    u_xlat4.x = (-u_xlat0.y) + u_xlat0.w;
    u_xlat4.x = u_xlat4.x / u_xlat5.x;
    u_xlat4.x = u_xlat4.x + u_xlat0.z;
    u_xlat2.x = abs(u_xlat4.x);
    u_xlat11.x = u_xlat2.x + FGlobals._HueSatCon.xyzx.x;
    u_xlat3.y = float(0.25);
    u_xlat11.y = float(0.25);
    u_xlat4.x = float(_Curves.sample(sampler_Curves, u_xlat11.xy, level(0.0)).x);
    u_xlat4.y = float(_Curves.sample(sampler_Curves, u_xlat3.xy, level(0.0)).w);
    u_xlat4.xy = u_xlat4.xy;
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0f, 1.0f);
    u_xlat4.x = u_xlat11.x + u_xlat4.x;
    u_xlat5.xyz = u_xlat4.xxx + float3(-0.5, 0.5, -1.5);
    u_xlatb4 = 1.0<u_xlat5.x;
    u_xlat4.x = (u_xlatb4) ? u_xlat5.z : u_xlat5.x;
    u_xlatb12 = u_xlat5.x<0.0;
    u_xlat4.x = (u_xlatb12) ? u_xlat5.y : u_xlat4.x;
    u_xlat5.xyz = u_xlat4.xxx + float3(1.0, 0.666666687, 0.333333343);
    u_xlat5.xyz = fract(u_xlat5.xyz);
    u_xlat5.xyz = fma(u_xlat5.xyz, float3(6.0, 6.0, 6.0), float3(-3.0, -3.0, -3.0));
    u_xlat5.xyz = abs(u_xlat5.xyz) + float3(-1.0, -1.0, -1.0);
    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0f, 1.0f);
    u_xlat5.xyz = u_xlat5.xyz + float3(-1.0, -1.0, -1.0);
    u_xlat4.x = u_xlat0.x + 9.99999975e-05;
    u_xlat10.x = u_xlat1.x / u_xlat4.x;
    u_xlat1.xyz = fma(u_xlat10.xxx, u_xlat5.xyz, float3(1.0, 1.0, 1.0));
    u_xlat3.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat4.x = dot(u_xlat3.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat1.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, (-u_xlat4.xxx));
    u_xlat2.y = float(0.25);
    u_xlat10.y = float(0.25);
    u_xlat0.x = float(_Curves.sample(sampler_Curves, u_xlat2.xy, level(0.0)).y);
    u_xlat0.w = float(_Curves.sample(sampler_Curves, u_xlat10.xy, level(0.0)).z);
    u_xlat0.xw = u_xlat0.xw;
    u_xlat0.xw = clamp(u_xlat0.xw, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = dot(u_xlat0.ww, u_xlat0.xx);
    u_xlat0.x = u_xlat0.x * u_xlat4.y;
    u_xlat0.x = dot(FGlobals._HueSatCon.xyzx.yy, u_xlat0.xx);
    u_xlat0.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, u_xlat4.xxx);
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlat1.xyz = fma(u_xlat0.xyz, float3(0.262677222, 0.262677222, 0.262677222), float3(0.0695999935, 0.0695999935, 0.0695999935));
    u_xlat2.xyz = u_xlat0.xyz * float3(1.31338608, 1.31338608, 1.31338608);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(0.262677222, 0.262677222, 0.262677222), float3(0.289999992, 0.289999992, 0.289999992));
    u_xlat0.xyz = fma(u_xlat2.xyz, u_xlat0.xyz, float3(0.0816000104, 0.0816000104, 0.0816000104));
    u_xlat1.xyz = fma(u_xlat2.xyz, u_xlat1.xyz, float3(0.00543999998, 0.00543999998, 0.00543999998));
    u_xlat0.xyz = u_xlat1.xyz / u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + float3(-0.0666666627, -0.0666666627, -0.0666666627);
    u_xlat0.xyz = u_xlat0.xyz * float3(1.31338608, 1.31338608, 1.31338608);
    output.SV_Target0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    output.SV_Target0.w = 1.0;
    return output;
}
"
}
SubProgram "metal hw_tier00 " {
Keywords { "TONEMAPPING_CUSTOM" }
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
    float4 _Lut2D_Params;
    float3 _ColorBalance;
    float3 _ColorFilter;
    float3 _HueSatCon;
    float3 _ChannelMixerRed;
    float3 _ChannelMixerGreen;
    float3 _ChannelMixerBlue;
    float3 _Lift;
    float3 _InvGamma;
    float3 _Gain;
    float4 _CustomToneCurve;
    float4 _ToeSegmentA;
    float4 _ToeSegmentB;
    float4 _MidSegmentA;
    float4 _MidSegmentB;
    float4 _ShoSegmentA;
    float4 _ShoSegmentB;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_Curves [[ sampler (0) ]],
    texture2d<half, access::sample > _Curves [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    bool u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    bool4 u_xlatb2;
    float4 u_xlat3;
    float4 u_xlat4;
    float2 u_xlat5;
    bool u_xlatb5;
    float3 u_xlat6;
    float u_xlat10;
    bool u_xlatb10;
    bool2 u_xlatb11;
    float2 u_xlat12;
    float2 u_xlat13;
    float u_xlat15;
    bool u_xlatb15;
    u_xlat0.yz = input.TEXCOORD0.xy + (-FGlobals._Lut2D_Params.yz);
    u_xlat1.x = u_xlat0.y * FGlobals._Lut2D_Params.x;
    u_xlat0.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat0.x / FGlobals._Lut2D_Params.x;
    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
    u_xlat0.xyz = fma(u_xlat0.xzw, FGlobals._Lut2D_Params.www, float3(-0.413588405, -0.413588405, -0.413588405));
    u_xlat0.xyz = fma(u_xlat0.xyz, FGlobals._HueSatCon.xyzx.zzz, float3(0.0275523961, 0.0275523961, 0.0275523961));
    u_xlat0.xyz = u_xlat0.xyz * float3(13.6054821, 13.6054821, 13.6054821);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + float3(-0.0479959995, -0.0479959995, -0.0479959995);
    u_xlat0.xyz = u_xlat0.xyz * float3(0.179999992, 0.179999992, 0.179999992);
    u_xlat1.x = dot(float3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
    u_xlat1.y = dot(float3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
    u_xlat1.z = dot(float3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorBalance.xyzx.xyz;
    u_xlat1.x = dot(float3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
    u_xlat1.y = dot(float3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
    u_xlat1.z = dot(float3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorFilter.xyzx.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, FGlobals._ChannelMixerRed.xyzx.xyz);
    u_xlat1.y = dot(u_xlat0.xyz, FGlobals._ChannelMixerGreen.xyzx.xyz);
    u_xlat1.z = dot(u_xlat0.xyz, FGlobals._ChannelMixerBlue.xyzx.xyz);
    u_xlat0.xyz = fma(u_xlat1.xyz, FGlobals._Gain.xyzx.xyz, FGlobals._Lift.xyzx.xyz);
    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38), float3(0.5, 0.5, 0.5));
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(2.0, 2.0, 2.0), float3(-1.0, -1.0, -1.0));
    u_xlat1.xyz = u_xlat1.xyz * FGlobals._InvGamma.xyzx.xyz;
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlatb15 = u_xlat0.y>=u_xlat0.z;
    u_xlat15 = u_xlatb15 ? 1.0 : float(0.0);
    u_xlat1.xy = u_xlat0.zy;
    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
    u_xlat1.z = float(-1.0);
    u_xlat1.w = float(0.666666687);
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(-1.0);
    u_xlat1 = fma(float4(u_xlat15), u_xlat2.xywz, u_xlat1.xywz);
    u_xlatb15 = u_xlat0.x>=u_xlat1.x;
    u_xlat15 = u_xlatb15 ? 1.0 : float(0.0);
    u_xlat2.z = u_xlat1.w;
    u_xlat1.w = u_xlat0.x;
    u_xlat3.x = dot(u_xlat0.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat2.xyw = u_xlat1.wyx;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = fma(float4(u_xlat15), u_xlat2, u_xlat1);
    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
    u_xlat6.x = fma(u_xlat1.x, 6.0, 9.99999975e-05);
    u_xlat5.x = (-u_xlat0.y) + u_xlat0.w;
    u_xlat5.x = u_xlat5.x / u_xlat6.x;
    u_xlat5.x = u_xlat5.x + u_xlat0.z;
    u_xlat2.x = abs(u_xlat5.x);
    u_xlat13.x = u_xlat2.x + FGlobals._HueSatCon.xyzx.x;
    u_xlat3.y = float(0.25);
    u_xlat13.y = float(0.25);
    u_xlat5.x = float(_Curves.sample(sampler_Curves, u_xlat13.xy, level(0.0)).x);
    u_xlat5.y = float(_Curves.sample(sampler_Curves, u_xlat3.xy, level(0.0)).w);
    u_xlat5.xy = u_xlat5.xy;
    u_xlat5.xy = clamp(u_xlat5.xy, 0.0f, 1.0f);
    u_xlat5.x = u_xlat13.x + u_xlat5.x;
    u_xlat6.xyz = u_xlat5.xxx + float3(-0.5, 0.5, -1.5);
    u_xlatb5 = 1.0<u_xlat6.x;
    u_xlat5.x = (u_xlatb5) ? u_xlat6.z : u_xlat6.x;
    u_xlatb15 = u_xlat6.x<0.0;
    u_xlat5.x = (u_xlatb15) ? u_xlat6.y : u_xlat5.x;
    u_xlat6.xyz = u_xlat5.xxx + float3(1.0, 0.666666687, 0.333333343);
    u_xlat6.xyz = fract(u_xlat6.xyz);
    u_xlat6.xyz = fma(u_xlat6.xyz, float3(6.0, 6.0, 6.0), float3(-3.0, -3.0, -3.0));
    u_xlat6.xyz = abs(u_xlat6.xyz) + float3(-1.0, -1.0, -1.0);
    u_xlat6.xyz = clamp(u_xlat6.xyz, 0.0f, 1.0f);
    u_xlat6.xyz = u_xlat6.xyz + float3(-1.0, -1.0, -1.0);
    u_xlat5.x = u_xlat0.x + 9.99999975e-05;
    u_xlat12.x = u_xlat1.x / u_xlat5.x;
    u_xlat1.xyz = fma(u_xlat12.xxx, u_xlat6.xyz, float3(1.0, 1.0, 1.0));
    u_xlat3.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat5.x = dot(u_xlat3.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat1.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, (-u_xlat5.xxx));
    u_xlat2.y = float(0.25);
    u_xlat12.y = float(0.25);
    u_xlat0.x = float(_Curves.sample(sampler_Curves, u_xlat2.xy, level(0.0)).y);
    u_xlat0.w = float(_Curves.sample(sampler_Curves, u_xlat12.xy, level(0.0)).z);
    u_xlat0.xw = u_xlat0.xw;
    u_xlat0.xw = clamp(u_xlat0.xw, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = dot(u_xlat0.ww, u_xlat0.xx);
    u_xlat0.x = u_xlat0.x * u_xlat5.y;
    u_xlat0.x = dot(FGlobals._HueSatCon.xyzx.yy, u_xlat0.xx);
    u_xlat0.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, u_xlat5.xxx);
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlat1.xyz = u_xlat0.xyz * FGlobals._CustomToneCurve.xxx;
    u_xlatb11.xy = (u_xlat1.zz<FGlobals._CustomToneCurve.yz);
    u_xlatb2 = (u_xlat1.xxyy<FGlobals._CustomToneCurve.yzyz);
    u_xlat3 = (u_xlatb11.y) ? FGlobals._MidSegmentA : FGlobals._ShoSegmentA;
    u_xlat3 = (u_xlatb11.x) ? FGlobals._ToeSegmentA : u_xlat3;
    u_xlat10 = fma(u_xlat0.z, FGlobals._CustomToneCurve.x, (-u_xlat3.x));
    u_xlat10 = u_xlat3.z * u_xlat10;
    u_xlat15 = log2(u_xlat10);
    u_xlatb10 = 0.0<u_xlat10;
    u_xlat1.xy = (u_xlatb11.y) ? FGlobals._MidSegmentB.xy : FGlobals._ShoSegmentB.xy;
    u_xlat1.xy = (u_xlatb11.x) ? FGlobals._ToeSegmentB.xy : u_xlat1.xy;
    u_xlat15 = u_xlat15 * u_xlat1.y;
    u_xlat15 = fma(u_xlat15, 0.693147182, u_xlat1.x);
    u_xlat15 = u_xlat15 * 1.44269502;
    u_xlat15 = exp2(u_xlat15);
    u_xlat10 = u_xlatb10 ? u_xlat15 : float(0.0);
    u_xlat1.z = fma(u_xlat10, u_xlat3.w, u_xlat3.y);
    u_xlat3 = (u_xlatb2.y) ? FGlobals._MidSegmentA : FGlobals._ShoSegmentA;
    u_xlat3 = (u_xlatb2.x) ? FGlobals._ToeSegmentA : u_xlat3;
    u_xlat0.x = fma(u_xlat0.x, FGlobals._CustomToneCurve.x, (-u_xlat3.x));
    u_xlat0.x = u_xlat3.z * u_xlat0.x;
    u_xlat10 = log2(u_xlat0.x);
    u_xlatb0 = 0.0<u_xlat0.x;
    u_xlat4.x = (u_xlatb2.y) ? FGlobals._MidSegmentB.x : FGlobals._ShoSegmentB.x;
    u_xlat4.y = (u_xlatb2.y) ? FGlobals._MidSegmentB.y : FGlobals._ShoSegmentB.y;
    u_xlat4.z = (u_xlatb2.w) ? FGlobals._MidSegmentB.x : FGlobals._ShoSegmentB.x;
    u_xlat4.w = (u_xlatb2.w) ? FGlobals._MidSegmentB.y : FGlobals._ShoSegmentB.y;
    {
        float4 hlslcc_movcTemp = u_xlat4;
        hlslcc_movcTemp.x = (u_xlatb2.x) ? FGlobals._ToeSegmentB.x : u_xlat4.x;
        hlslcc_movcTemp.y = (u_xlatb2.x) ? FGlobals._ToeSegmentB.y : u_xlat4.y;
        hlslcc_movcTemp.z = (u_xlatb2.z) ? FGlobals._ToeSegmentB.x : u_xlat4.z;
        hlslcc_movcTemp.w = (u_xlatb2.z) ? FGlobals._ToeSegmentB.y : u_xlat4.w;
        u_xlat4 = hlslcc_movcTemp;
    }
    u_xlat10 = u_xlat10 * u_xlat4.y;
    u_xlat10 = fma(u_xlat10, 0.693147182, u_xlat4.x);
    u_xlat10 = u_xlat10 * 1.44269502;
    u_xlat10 = exp2(u_xlat10);
    u_xlat0.x = u_xlatb0 ? u_xlat10 : float(0.0);
    u_xlat1.x = fma(u_xlat0.x, u_xlat3.w, u_xlat3.y);
    u_xlat3 = (u_xlatb2.w) ? FGlobals._MidSegmentA : FGlobals._ShoSegmentA;
    u_xlat2 = (u_xlatb2.z) ? FGlobals._ToeSegmentA : u_xlat3;
    u_xlat0.x = fma(u_xlat0.y, FGlobals._CustomToneCurve.x, (-u_xlat2.x));
    u_xlat0.x = u_xlat2.z * u_xlat0.x;
    u_xlat5.x = log2(u_xlat0.x);
    u_xlatb0 = 0.0<u_xlat0.x;
    u_xlat5.x = u_xlat5.x * u_xlat4.w;
    u_xlat5.x = fma(u_xlat5.x, 0.693147182, u_xlat4.z);
    u_xlat5.x = u_xlat5.x * 1.44269502;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat0.x = u_xlatb0 ? u_xlat5.x : float(0.0);
    u_xlat1.y = fma(u_xlat0.x, u_xlat2.w, u_xlat2.y);
    output.SV_Target0.xyz = max(u_xlat1.xyz, float3(0.0, 0.0, 0.0));
    output.SV_Target0.w = 1.0;
    return output;
}
"
}
SubProgram "metal hw_tier01 " {
Keywords { "TONEMAPPING_CUSTOM" }
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
    float4 _Lut2D_Params;
    float3 _ColorBalance;
    float3 _ColorFilter;
    float3 _HueSatCon;
    float3 _ChannelMixerRed;
    float3 _ChannelMixerGreen;
    float3 _ChannelMixerBlue;
    float3 _Lift;
    float3 _InvGamma;
    float3 _Gain;
    float4 _CustomToneCurve;
    float4 _ToeSegmentA;
    float4 _ToeSegmentB;
    float4 _MidSegmentA;
    float4 _MidSegmentB;
    float4 _ShoSegmentA;
    float4 _ShoSegmentB;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_Curves [[ sampler (0) ]],
    texture2d<half, access::sample > _Curves [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    bool u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    bool4 u_xlatb2;
    float4 u_xlat3;
    float4 u_xlat4;
    float2 u_xlat5;
    bool u_xlatb5;
    float3 u_xlat6;
    float u_xlat10;
    bool u_xlatb10;
    bool2 u_xlatb11;
    float2 u_xlat12;
    float2 u_xlat13;
    float u_xlat15;
    bool u_xlatb15;
    u_xlat0.yz = input.TEXCOORD0.xy + (-FGlobals._Lut2D_Params.yz);
    u_xlat1.x = u_xlat0.y * FGlobals._Lut2D_Params.x;
    u_xlat0.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat0.x / FGlobals._Lut2D_Params.x;
    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
    u_xlat0.xyz = fma(u_xlat0.xzw, FGlobals._Lut2D_Params.www, float3(-0.413588405, -0.413588405, -0.413588405));
    u_xlat0.xyz = fma(u_xlat0.xyz, FGlobals._HueSatCon.xyzx.zzz, float3(0.0275523961, 0.0275523961, 0.0275523961));
    u_xlat0.xyz = u_xlat0.xyz * float3(13.6054821, 13.6054821, 13.6054821);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + float3(-0.0479959995, -0.0479959995, -0.0479959995);
    u_xlat0.xyz = u_xlat0.xyz * float3(0.179999992, 0.179999992, 0.179999992);
    u_xlat1.x = dot(float3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
    u_xlat1.y = dot(float3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
    u_xlat1.z = dot(float3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorBalance.xyzx.xyz;
    u_xlat1.x = dot(float3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
    u_xlat1.y = dot(float3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
    u_xlat1.z = dot(float3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorFilter.xyzx.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, FGlobals._ChannelMixerRed.xyzx.xyz);
    u_xlat1.y = dot(u_xlat0.xyz, FGlobals._ChannelMixerGreen.xyzx.xyz);
    u_xlat1.z = dot(u_xlat0.xyz, FGlobals._ChannelMixerBlue.xyzx.xyz);
    u_xlat0.xyz = fma(u_xlat1.xyz, FGlobals._Gain.xyzx.xyz, FGlobals._Lift.xyzx.xyz);
    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38), float3(0.5, 0.5, 0.5));
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(2.0, 2.0, 2.0), float3(-1.0, -1.0, -1.0));
    u_xlat1.xyz = u_xlat1.xyz * FGlobals._InvGamma.xyzx.xyz;
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlatb15 = u_xlat0.y>=u_xlat0.z;
    u_xlat15 = u_xlatb15 ? 1.0 : float(0.0);
    u_xlat1.xy = u_xlat0.zy;
    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
    u_xlat1.z = float(-1.0);
    u_xlat1.w = float(0.666666687);
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(-1.0);
    u_xlat1 = fma(float4(u_xlat15), u_xlat2.xywz, u_xlat1.xywz);
    u_xlatb15 = u_xlat0.x>=u_xlat1.x;
    u_xlat15 = u_xlatb15 ? 1.0 : float(0.0);
    u_xlat2.z = u_xlat1.w;
    u_xlat1.w = u_xlat0.x;
    u_xlat3.x = dot(u_xlat0.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat2.xyw = u_xlat1.wyx;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = fma(float4(u_xlat15), u_xlat2, u_xlat1);
    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
    u_xlat6.x = fma(u_xlat1.x, 6.0, 9.99999975e-05);
    u_xlat5.x = (-u_xlat0.y) + u_xlat0.w;
    u_xlat5.x = u_xlat5.x / u_xlat6.x;
    u_xlat5.x = u_xlat5.x + u_xlat0.z;
    u_xlat2.x = abs(u_xlat5.x);
    u_xlat13.x = u_xlat2.x + FGlobals._HueSatCon.xyzx.x;
    u_xlat3.y = float(0.25);
    u_xlat13.y = float(0.25);
    u_xlat5.x = float(_Curves.sample(sampler_Curves, u_xlat13.xy, level(0.0)).x);
    u_xlat5.y = float(_Curves.sample(sampler_Curves, u_xlat3.xy, level(0.0)).w);
    u_xlat5.xy = u_xlat5.xy;
    u_xlat5.xy = clamp(u_xlat5.xy, 0.0f, 1.0f);
    u_xlat5.x = u_xlat13.x + u_xlat5.x;
    u_xlat6.xyz = u_xlat5.xxx + float3(-0.5, 0.5, -1.5);
    u_xlatb5 = 1.0<u_xlat6.x;
    u_xlat5.x = (u_xlatb5) ? u_xlat6.z : u_xlat6.x;
    u_xlatb15 = u_xlat6.x<0.0;
    u_xlat5.x = (u_xlatb15) ? u_xlat6.y : u_xlat5.x;
    u_xlat6.xyz = u_xlat5.xxx + float3(1.0, 0.666666687, 0.333333343);
    u_xlat6.xyz = fract(u_xlat6.xyz);
    u_xlat6.xyz = fma(u_xlat6.xyz, float3(6.0, 6.0, 6.0), float3(-3.0, -3.0, -3.0));
    u_xlat6.xyz = abs(u_xlat6.xyz) + float3(-1.0, -1.0, -1.0);
    u_xlat6.xyz = clamp(u_xlat6.xyz, 0.0f, 1.0f);
    u_xlat6.xyz = u_xlat6.xyz + float3(-1.0, -1.0, -1.0);
    u_xlat5.x = u_xlat0.x + 9.99999975e-05;
    u_xlat12.x = u_xlat1.x / u_xlat5.x;
    u_xlat1.xyz = fma(u_xlat12.xxx, u_xlat6.xyz, float3(1.0, 1.0, 1.0));
    u_xlat3.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat5.x = dot(u_xlat3.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat1.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, (-u_xlat5.xxx));
    u_xlat2.y = float(0.25);
    u_xlat12.y = float(0.25);
    u_xlat0.x = float(_Curves.sample(sampler_Curves, u_xlat2.xy, level(0.0)).y);
    u_xlat0.w = float(_Curves.sample(sampler_Curves, u_xlat12.xy, level(0.0)).z);
    u_xlat0.xw = u_xlat0.xw;
    u_xlat0.xw = clamp(u_xlat0.xw, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = dot(u_xlat0.ww, u_xlat0.xx);
    u_xlat0.x = u_xlat0.x * u_xlat5.y;
    u_xlat0.x = dot(FGlobals._HueSatCon.xyzx.yy, u_xlat0.xx);
    u_xlat0.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, u_xlat5.xxx);
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlat1.xyz = u_xlat0.xyz * FGlobals._CustomToneCurve.xxx;
    u_xlatb11.xy = (u_xlat1.zz<FGlobals._CustomToneCurve.yz);
    u_xlatb2 = (u_xlat1.xxyy<FGlobals._CustomToneCurve.yzyz);
    u_xlat3 = (u_xlatb11.y) ? FGlobals._MidSegmentA : FGlobals._ShoSegmentA;
    u_xlat3 = (u_xlatb11.x) ? FGlobals._ToeSegmentA : u_xlat3;
    u_xlat10 = fma(u_xlat0.z, FGlobals._CustomToneCurve.x, (-u_xlat3.x));
    u_xlat10 = u_xlat3.z * u_xlat10;
    u_xlat15 = log2(u_xlat10);
    u_xlatb10 = 0.0<u_xlat10;
    u_xlat1.xy = (u_xlatb11.y) ? FGlobals._MidSegmentB.xy : FGlobals._ShoSegmentB.xy;
    u_xlat1.xy = (u_xlatb11.x) ? FGlobals._ToeSegmentB.xy : u_xlat1.xy;
    u_xlat15 = u_xlat15 * u_xlat1.y;
    u_xlat15 = fma(u_xlat15, 0.693147182, u_xlat1.x);
    u_xlat15 = u_xlat15 * 1.44269502;
    u_xlat15 = exp2(u_xlat15);
    u_xlat10 = u_xlatb10 ? u_xlat15 : float(0.0);
    u_xlat1.z = fma(u_xlat10, u_xlat3.w, u_xlat3.y);
    u_xlat3 = (u_xlatb2.y) ? FGlobals._MidSegmentA : FGlobals._ShoSegmentA;
    u_xlat3 = (u_xlatb2.x) ? FGlobals._ToeSegmentA : u_xlat3;
    u_xlat0.x = fma(u_xlat0.x, FGlobals._CustomToneCurve.x, (-u_xlat3.x));
    u_xlat0.x = u_xlat3.z * u_xlat0.x;
    u_xlat10 = log2(u_xlat0.x);
    u_xlatb0 = 0.0<u_xlat0.x;
    u_xlat4.x = (u_xlatb2.y) ? FGlobals._MidSegmentB.x : FGlobals._ShoSegmentB.x;
    u_xlat4.y = (u_xlatb2.y) ? FGlobals._MidSegmentB.y : FGlobals._ShoSegmentB.y;
    u_xlat4.z = (u_xlatb2.w) ? FGlobals._MidSegmentB.x : FGlobals._ShoSegmentB.x;
    u_xlat4.w = (u_xlatb2.w) ? FGlobals._MidSegmentB.y : FGlobals._ShoSegmentB.y;
    {
        float4 hlslcc_movcTemp = u_xlat4;
        hlslcc_movcTemp.x = (u_xlatb2.x) ? FGlobals._ToeSegmentB.x : u_xlat4.x;
        hlslcc_movcTemp.y = (u_xlatb2.x) ? FGlobals._ToeSegmentB.y : u_xlat4.y;
        hlslcc_movcTemp.z = (u_xlatb2.z) ? FGlobals._ToeSegmentB.x : u_xlat4.z;
        hlslcc_movcTemp.w = (u_xlatb2.z) ? FGlobals._ToeSegmentB.y : u_xlat4.w;
        u_xlat4 = hlslcc_movcTemp;
    }
    u_xlat10 = u_xlat10 * u_xlat4.y;
    u_xlat10 = fma(u_xlat10, 0.693147182, u_xlat4.x);
    u_xlat10 = u_xlat10 * 1.44269502;
    u_xlat10 = exp2(u_xlat10);
    u_xlat0.x = u_xlatb0 ? u_xlat10 : float(0.0);
    u_xlat1.x = fma(u_xlat0.x, u_xlat3.w, u_xlat3.y);
    u_xlat3 = (u_xlatb2.w) ? FGlobals._MidSegmentA : FGlobals._ShoSegmentA;
    u_xlat2 = (u_xlatb2.z) ? FGlobals._ToeSegmentA : u_xlat3;
    u_xlat0.x = fma(u_xlat0.y, FGlobals._CustomToneCurve.x, (-u_xlat2.x));
    u_xlat0.x = u_xlat2.z * u_xlat0.x;
    u_xlat5.x = log2(u_xlat0.x);
    u_xlatb0 = 0.0<u_xlat0.x;
    u_xlat5.x = u_xlat5.x * u_xlat4.w;
    u_xlat5.x = fma(u_xlat5.x, 0.693147182, u_xlat4.z);
    u_xlat5.x = u_xlat5.x * 1.44269502;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat0.x = u_xlatb0 ? u_xlat5.x : float(0.0);
    u_xlat1.y = fma(u_xlat0.x, u_xlat2.w, u_xlat2.y);
    output.SV_Target0.xyz = max(u_xlat1.xyz, float3(0.0, 0.0, 0.0));
    output.SV_Target0.w = 1.0;
    return output;
}
"
}
SubProgram "metal hw_tier02 " {
Keywords { "TONEMAPPING_CUSTOM" }
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
    float4 _Lut2D_Params;
    float3 _ColorBalance;
    float3 _ColorFilter;
    float3 _HueSatCon;
    float3 _ChannelMixerRed;
    float3 _ChannelMixerGreen;
    float3 _ChannelMixerBlue;
    float3 _Lift;
    float3 _InvGamma;
    float3 _Gain;
    float4 _CustomToneCurve;
    float4 _ToeSegmentA;
    float4 _ToeSegmentB;
    float4 _MidSegmentA;
    float4 _MidSegmentB;
    float4 _ShoSegmentA;
    float4 _ShoSegmentB;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_Curves [[ sampler (0) ]],
    texture2d<half, access::sample > _Curves [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    bool u_xlatb0;
    float4 u_xlat1;
    float4 u_xlat2;
    bool4 u_xlatb2;
    float4 u_xlat3;
    float4 u_xlat4;
    float2 u_xlat5;
    bool u_xlatb5;
    float3 u_xlat6;
    float u_xlat10;
    bool u_xlatb10;
    bool2 u_xlatb11;
    float2 u_xlat12;
    float2 u_xlat13;
    float u_xlat15;
    bool u_xlatb15;
    u_xlat0.yz = input.TEXCOORD0.xy + (-FGlobals._Lut2D_Params.yz);
    u_xlat1.x = u_xlat0.y * FGlobals._Lut2D_Params.x;
    u_xlat0.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat0.x / FGlobals._Lut2D_Params.x;
    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
    u_xlat0.xyz = fma(u_xlat0.xzw, FGlobals._Lut2D_Params.www, float3(-0.413588405, -0.413588405, -0.413588405));
    u_xlat0.xyz = fma(u_xlat0.xyz, FGlobals._HueSatCon.xyzx.zzz, float3(0.0275523961, 0.0275523961, 0.0275523961));
    u_xlat0.xyz = u_xlat0.xyz * float3(13.6054821, 13.6054821, 13.6054821);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + float3(-0.0479959995, -0.0479959995, -0.0479959995);
    u_xlat0.xyz = u_xlat0.xyz * float3(0.179999992, 0.179999992, 0.179999992);
    u_xlat1.x = dot(float3(0.390404999, 0.549941003, 0.00892631989), u_xlat0.xyz);
    u_xlat1.y = dot(float3(0.070841603, 0.963172019, 0.00135775004), u_xlat0.xyz);
    u_xlat1.z = dot(float3(0.0231081992, 0.128021002, 0.936245024), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorBalance.xyzx.xyz;
    u_xlat1.x = dot(float3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
    u_xlat1.y = dot(float3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
    u_xlat1.z = dot(float3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.xyz * FGlobals._ColorFilter.xyzx.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, FGlobals._ChannelMixerRed.xyzx.xyz);
    u_xlat1.y = dot(u_xlat0.xyz, FGlobals._ChannelMixerGreen.xyzx.xyz);
    u_xlat1.z = dot(u_xlat0.xyz, FGlobals._ChannelMixerBlue.xyzx.xyz);
    u_xlat0.xyz = fma(u_xlat1.xyz, FGlobals._Gain.xyzx.xyz, FGlobals._Lift.xyzx.xyz);
    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(3.40282347e+38, 3.40282347e+38, 3.40282347e+38), float3(0.5, 0.5, 0.5));
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(2.0, 2.0, 2.0), float3(-1.0, -1.0, -1.0));
    u_xlat1.xyz = u_xlat1.xyz * FGlobals._InvGamma.xyzx.xyz;
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlatb15 = u_xlat0.y>=u_xlat0.z;
    u_xlat15 = u_xlatb15 ? 1.0 : float(0.0);
    u_xlat1.xy = u_xlat0.zy;
    u_xlat2.xy = u_xlat0.yz + (-u_xlat1.xy);
    u_xlat1.z = float(-1.0);
    u_xlat1.w = float(0.666666687);
    u_xlat2.z = float(1.0);
    u_xlat2.w = float(-1.0);
    u_xlat1 = fma(float4(u_xlat15), u_xlat2.xywz, u_xlat1.xywz);
    u_xlatb15 = u_xlat0.x>=u_xlat1.x;
    u_xlat15 = u_xlatb15 ? 1.0 : float(0.0);
    u_xlat2.z = u_xlat1.w;
    u_xlat1.w = u_xlat0.x;
    u_xlat3.x = dot(u_xlat0.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat2.xyw = u_xlat1.wyx;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = fma(float4(u_xlat15), u_xlat2, u_xlat1);
    u_xlat1.x = min(u_xlat0.y, u_xlat0.w);
    u_xlat1.x = u_xlat0.x + (-u_xlat1.x);
    u_xlat6.x = fma(u_xlat1.x, 6.0, 9.99999975e-05);
    u_xlat5.x = (-u_xlat0.y) + u_xlat0.w;
    u_xlat5.x = u_xlat5.x / u_xlat6.x;
    u_xlat5.x = u_xlat5.x + u_xlat0.z;
    u_xlat2.x = abs(u_xlat5.x);
    u_xlat13.x = u_xlat2.x + FGlobals._HueSatCon.xyzx.x;
    u_xlat3.y = float(0.25);
    u_xlat13.y = float(0.25);
    u_xlat5.x = float(_Curves.sample(sampler_Curves, u_xlat13.xy, level(0.0)).x);
    u_xlat5.y = float(_Curves.sample(sampler_Curves, u_xlat3.xy, level(0.0)).w);
    u_xlat5.xy = u_xlat5.xy;
    u_xlat5.xy = clamp(u_xlat5.xy, 0.0f, 1.0f);
    u_xlat5.x = u_xlat13.x + u_xlat5.x;
    u_xlat6.xyz = u_xlat5.xxx + float3(-0.5, 0.5, -1.5);
    u_xlatb5 = 1.0<u_xlat6.x;
    u_xlat5.x = (u_xlatb5) ? u_xlat6.z : u_xlat6.x;
    u_xlatb15 = u_xlat6.x<0.0;
    u_xlat5.x = (u_xlatb15) ? u_xlat6.y : u_xlat5.x;
    u_xlat6.xyz = u_xlat5.xxx + float3(1.0, 0.666666687, 0.333333343);
    u_xlat6.xyz = fract(u_xlat6.xyz);
    u_xlat6.xyz = fma(u_xlat6.xyz, float3(6.0, 6.0, 6.0), float3(-3.0, -3.0, -3.0));
    u_xlat6.xyz = abs(u_xlat6.xyz) + float3(-1.0, -1.0, -1.0);
    u_xlat6.xyz = clamp(u_xlat6.xyz, 0.0f, 1.0f);
    u_xlat6.xyz = u_xlat6.xyz + float3(-1.0, -1.0, -1.0);
    u_xlat5.x = u_xlat0.x + 9.99999975e-05;
    u_xlat12.x = u_xlat1.x / u_xlat5.x;
    u_xlat1.xyz = fma(u_xlat12.xxx, u_xlat6.xyz, float3(1.0, 1.0, 1.0));
    u_xlat3.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat5.x = dot(u_xlat3.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat1.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, (-u_xlat5.xxx));
    u_xlat2.y = float(0.25);
    u_xlat12.y = float(0.25);
    u_xlat0.x = float(_Curves.sample(sampler_Curves, u_xlat2.xy, level(0.0)).y);
    u_xlat0.w = float(_Curves.sample(sampler_Curves, u_xlat12.xy, level(0.0)).z);
    u_xlat0.xw = u_xlat0.xw;
    u_xlat0.xw = clamp(u_xlat0.xw, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = dot(u_xlat0.ww, u_xlat0.xx);
    u_xlat0.x = u_xlat0.x * u_xlat5.y;
    u_xlat0.x = dot(FGlobals._HueSatCon.xyzx.yy, u_xlat0.xx);
    u_xlat0.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, u_xlat5.xxx);
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlat1.xyz = u_xlat0.xyz * FGlobals._CustomToneCurve.xxx;
    u_xlatb11.xy = (u_xlat1.zz<FGlobals._CustomToneCurve.yz);
    u_xlatb2 = (u_xlat1.xxyy<FGlobals._CustomToneCurve.yzyz);
    u_xlat3 = (u_xlatb11.y) ? FGlobals._MidSegmentA : FGlobals._ShoSegmentA;
    u_xlat3 = (u_xlatb11.x) ? FGlobals._ToeSegmentA : u_xlat3;
    u_xlat10 = fma(u_xlat0.z, FGlobals._CustomToneCurve.x, (-u_xlat3.x));
    u_xlat10 = u_xlat3.z * u_xlat10;
    u_xlat15 = log2(u_xlat10);
    u_xlatb10 = 0.0<u_xlat10;
    u_xlat1.xy = (u_xlatb11.y) ? FGlobals._MidSegmentB.xy : FGlobals._ShoSegmentB.xy;
    u_xlat1.xy = (u_xlatb11.x) ? FGlobals._ToeSegmentB.xy : u_xlat1.xy;
    u_xlat15 = u_xlat15 * u_xlat1.y;
    u_xlat15 = fma(u_xlat15, 0.693147182, u_xlat1.x);
    u_xlat15 = u_xlat15 * 1.44269502;
    u_xlat15 = exp2(u_xlat15);
    u_xlat10 = u_xlatb10 ? u_xlat15 : float(0.0);
    u_xlat1.z = fma(u_xlat10, u_xlat3.w, u_xlat3.y);
    u_xlat3 = (u_xlatb2.y) ? FGlobals._MidSegmentA : FGlobals._ShoSegmentA;
    u_xlat3 = (u_xlatb2.x) ? FGlobals._ToeSegmentA : u_xlat3;
    u_xlat0.x = fma(u_xlat0.x, FGlobals._CustomToneCurve.x, (-u_xlat3.x));
    u_xlat0.x = u_xlat3.z * u_xlat0.x;
    u_xlat10 = log2(u_xlat0.x);
    u_xlatb0 = 0.0<u_xlat0.x;
    u_xlat4.x = (u_xlatb2.y) ? FGlobals._MidSegmentB.x : FGlobals._ShoSegmentB.x;
    u_xlat4.y = (u_xlatb2.y) ? FGlobals._MidSegmentB.y : FGlobals._ShoSegmentB.y;
    u_xlat4.z = (u_xlatb2.w) ? FGlobals._MidSegmentB.x : FGlobals._ShoSegmentB.x;
    u_xlat4.w = (u_xlatb2.w) ? FGlobals._MidSegmentB.y : FGlobals._ShoSegmentB.y;
    {
        float4 hlslcc_movcTemp = u_xlat4;
        hlslcc_movcTemp.x = (u_xlatb2.x) ? FGlobals._ToeSegmentB.x : u_xlat4.x;
        hlslcc_movcTemp.y = (u_xlatb2.x) ? FGlobals._ToeSegmentB.y : u_xlat4.y;
        hlslcc_movcTemp.z = (u_xlatb2.z) ? FGlobals._ToeSegmentB.x : u_xlat4.z;
        hlslcc_movcTemp.w = (u_xlatb2.z) ? FGlobals._ToeSegmentB.y : u_xlat4.w;
        u_xlat4 = hlslcc_movcTemp;
    }
    u_xlat10 = u_xlat10 * u_xlat4.y;
    u_xlat10 = fma(u_xlat10, 0.693147182, u_xlat4.x);
    u_xlat10 = u_xlat10 * 1.44269502;
    u_xlat10 = exp2(u_xlat10);
    u_xlat0.x = u_xlatb0 ? u_xlat10 : float(0.0);
    u_xlat1.x = fma(u_xlat0.x, u_xlat3.w, u_xlat3.y);
    u_xlat3 = (u_xlatb2.w) ? FGlobals._MidSegmentA : FGlobals._ShoSegmentA;
    u_xlat2 = (u_xlatb2.z) ? FGlobals._ToeSegmentA : u_xlat3;
    u_xlat0.x = fma(u_xlat0.y, FGlobals._CustomToneCurve.x, (-u_xlat2.x));
    u_xlat0.x = u_xlat2.z * u_xlat0.x;
    u_xlat5.x = log2(u_xlat0.x);
    u_xlatb0 = 0.0<u_xlat0.x;
    u_xlat5.x = u_xlat5.x * u_xlat4.w;
    u_xlat5.x = fma(u_xlat5.x, 0.693147182, u_xlat4.z);
    u_xlat5.x = u_xlat5.x * 1.44269502;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat0.x = u_xlatb0 ? u_xlat5.x : float(0.0);
    u_xlat1.y = fma(u_xlat0.x, u_xlat2.w, u_xlat2.y);
    output.SV_Target0.xyz = max(u_xlat1.xyz, float3(0.0, 0.0, 0.0));
    output.SV_Target0.w = 1.0;
    return output;
}
"
}
}
}
}
}
//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/ScreenSpaceReflections" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 56199
Program "vp" {
SubProgram "metal hw_tier00 " {
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

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
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 phase0_Output0_1;
    float4 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0 = input.POSITION0.xyxy + float4(1.0, 1.0, 1.0, 1.0);
    phase0_Output0_1 = fma(u_xlat0, float4(0.5, -0.5, 0.5, -0.5), float4(0.0, 1.0, 0.0, 1.0));
    output.TEXCOORD0 = phase0_Output0_1.xy;
    output.TEXCOORD1 = phase0_Output0_1.zw;
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
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 phase0_Output0_1;
    float4 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0 = input.POSITION0.xyxy + float4(1.0, 1.0, 1.0, 1.0);
    phase0_Output0_1 = fma(u_xlat0, float4(0.5, -0.5, 0.5, -0.5), float4(0.0, 1.0, 0.0, 1.0));
    output.TEXCOORD0 = phase0_Output0_1.xy;
    output.TEXCOORD1 = phase0_Output0_1.zw;
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
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 phase0_Output0_1;
    float4 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0 = input.POSITION0.xyxy + float4(1.0, 1.0, 1.0, 1.0);
    phase0_Output0_1 = fma(u_xlat0, float4(0.5, -0.5, 0.5, -0.5), float4(0.0, 1.0, 0.0, 1.0));
    output.TEXCOORD0 = phase0_Output0_1.xy;
    output.TEXCOORD1 = phase0_Output0_1.zw;
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
    float3 _WorldSpaceCameraPos;
    float4 _ProjectionParams;
    float4 _ZBufferParams;
    float4 _Test_TexelSize;
    float4 hlslcc_mtx4x4_ViewMatrix[4];
    float4 hlslcc_mtx4x4_InverseProjectionMatrix[4];
    float4 hlslcc_mtx4x4_ScreenSpaceProjectionMatrix[4];
    float4 _Params;
    float4 _Params2;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (0) ]],
    sampler sampler_CameraGBufferTexture2 [[ sampler (1) ]],
    sampler sampler_Noise [[ sampler (2) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraGBufferTexture2 [[ texture(1) ]] ,
    texture2d<half, access::sample > _Noise [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    bool u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float4 u_xlat8;
    half u_xlat16_8;
    bool u_xlatb8;
    float u_xlat9;
    int u_xlati9;
    bool u_xlatb10;
    float2 u_xlat18;
    half u_xlat16_18;
    float u_xlat27;
    int u_xlati27;
    bool u_xlatb27;
    float u_xlat28;
    u_xlat16_0 = _CameraGBufferTexture2.sample(sampler_CameraGBufferTexture2, input.TEXCOORD1.xy);
    u_xlat27 = dot(float4(u_xlat16_0), float4(1.0, 1.0, 1.0, 1.0));
    u_xlatb27 = u_xlat27==0.0;
    if(u_xlatb27){
        output.SV_Target0 = float4(0.0, 0.0, 0.0, 0.0);
        return output;
    }
    u_xlat27 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD0.xy, level(0.0)).x;
    u_xlat1.xy = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat2 = u_xlat1.yyyy * FGlobals.hlslcc_mtx4x4_InverseProjectionMatrix[1];
    u_xlat1 = fma(FGlobals.hlslcc_mtx4x4_InverseProjectionMatrix[0], u_xlat1.xxxx, u_xlat2);
    u_xlat1 = fma(FGlobals.hlslcc_mtx4x4_InverseProjectionMatrix[2], float4(u_xlat27), u_xlat1);
    u_xlat1 = u_xlat1 + FGlobals.hlslcc_mtx4x4_InverseProjectionMatrix[3];
    u_xlat1.xyz = u_xlat1.xyz / u_xlat1.www;
    u_xlatb27 = u_xlat1.z<(-FGlobals._Params.z);
    if(u_xlatb27){
        output.SV_Target0 = float4(0.0, 0.0, 0.0, 0.0);
        return output;
    }
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat2.xyz = float3(u_xlat16_0.yyy) * FGlobals.hlslcc_mtx4x4_ViewMatrix[1].xyz;
    u_xlat0.xyw = fma(FGlobals.hlslcc_mtx4x4_ViewMatrix[0].xyz, float3(u_xlat16_0.xxx), u_xlat2.xyz);
    u_xlat0.xyz = fma(FGlobals.hlslcc_mtx4x4_ViewMatrix[2].xyz, float3(u_xlat16_0.zzz), u_xlat0.xyw);
    u_xlat27 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat2.xyz = float3(u_xlat27) * u_xlat1.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat0.xyz = fma(u_xlat0.xyz, (-float3(u_xlat27)), u_xlat2.xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlatb27 = 0.0<u_xlat0.z;
    if(u_xlatb27){
        output.SV_Target0 = float4(0.0, 0.0, 0.0, 0.0);
        return output;
    }
    u_xlat27 = fma(u_xlat0.z, FGlobals._Params.z, u_xlat1.z);
    u_xlatb27 = (-FGlobals._ProjectionParams.y)<u_xlat27;
    u_xlat28 = (-u_xlat1.z) + (-FGlobals._ProjectionParams.y);
    u_xlat28 = u_xlat28 / u_xlat0.z;
    u_xlat27 = (u_xlatb27) ? u_xlat28 : FGlobals._Params.z;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat27), u_xlat1.xyz);
    u_xlat2.xyz = u_xlat1.zzz * FGlobals.hlslcc_mtx4x4_ScreenSpaceProjectionMatrix[2].xyw;
    u_xlat3.z = fma(FGlobals.hlslcc_mtx4x4_ScreenSpaceProjectionMatrix[0].x, u_xlat1.x, u_xlat2.x);
    u_xlat3.w = fma(FGlobals.hlslcc_mtx4x4_ScreenSpaceProjectionMatrix[1].y, u_xlat1.y, u_xlat2.y);
    u_xlat1.xyw = u_xlat0.zzz * FGlobals.hlslcc_mtx4x4_ScreenSpaceProjectionMatrix[2].xyw;
    u_xlat3.x = fma(FGlobals.hlslcc_mtx4x4_ScreenSpaceProjectionMatrix[0].x, u_xlat0.x, u_xlat1.x);
    u_xlat3.y = fma(FGlobals.hlslcc_mtx4x4_ScreenSpaceProjectionMatrix[1].y, u_xlat0.y, u_xlat1.y);
    u_xlat2.zw = float2(1.0) / float2(u_xlat2.zz);
    u_xlat2.xy = float2(1.0) / float2(u_xlat1.ww);
    u_xlat4.w = u_xlat1.z * u_xlat2.w;
    u_xlat5 = u_xlat2.wzxy * u_xlat3.wzxy;
    u_xlat0.xy = fma(u_xlat3.zw, u_xlat2.zw, (-u_xlat5.zw));
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlatb0 = 9.99999975e-05>=u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat9 = max(FGlobals._Test_TexelSize.y, FGlobals._Test_TexelSize.x);
    u_xlat0.xy = fma(u_xlat0.xx, float2(u_xlat9), u_xlat5.wz);
    u_xlat5.zw = fma((-u_xlat3.wz), u_xlat2.wz, u_xlat0.xy);
    u_xlatb0 = abs(u_xlat5.w)<abs(u_xlat5.z);
    u_xlat3 = (bool(u_xlatb0)) ? u_xlat5 : u_xlat5.yxwz;
    u_xlati9 = int((0.0<u_xlat3.z) ? 0xFFFFFFFFu : uint(0));
    u_xlati27 = int((u_xlat3.z<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati9 = (-u_xlati9) + u_xlati27;
    u_xlat5.x = float(u_xlati9);
    u_xlat9 = u_xlat5.x / u_xlat3.z;
    u_xlat18.x = fma(u_xlat0.z, u_xlat2.y, (-u_xlat4.w));
    u_xlat5.w = u_xlat9 * u_xlat18.x;
    u_xlat5.y = u_xlat9 * u_xlat3.w;
    u_xlat18.x = (-u_xlat2.w) + u_xlat2.y;
    u_xlat5.z = u_xlat9 * u_xlat18.x;
    u_xlat9 = u_xlat1.z * -0.00999999978;
    u_xlat9 = min(u_xlat9, 1.0);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat1.xy = input.TEXCOORD0.xy * FGlobals._Params2.yy;
    u_xlat1.z = u_xlat1.y * FGlobals._Params2.x;
    u_xlat18.xy = u_xlat1.xz + FGlobals._WorldSpaceCameraPos.xyzx.xz;
    u_xlat16_18 = _Noise.sample(sampler_Noise, u_xlat18.xy, level(0.0)).w;
    u_xlat9 = u_xlat9 * FGlobals._Params2.z;
    u_xlat1 = float4(u_xlat9) * u_xlat5;
    u_xlat4.xy = u_xlat3.xy;
    u_xlat4.z = u_xlat2.w;
    u_xlat2 = fma(u_xlat1, float4(u_xlat16_18), u_xlat4);
    u_xlat3.x = as_type<float>(int(0xffffffffu));
    u_xlat4.x = float(0.0);
    u_xlat4.y = float(0.0);
    u_xlat4.z = float(0.0);
    u_xlat4.w = float(0.0);
    u_xlat6 = u_xlat2;
    u_xlat7.x = float(0.0);
    u_xlat7.y = float(0.0);
    u_xlat7.z = float(0.0);
    u_xlat7.w = float(0.0);
    u_xlat18.x = float(0.0);
    u_xlati27 = int(0x0);
    u_xlat16_8 = half(0.0);
    while(true){
        u_xlat1.x = float(u_xlati27);
        u_xlatb1 = u_xlat1.x>=FGlobals._Params2.w;
        u_xlat8.x = 0.0;
        if(u_xlatb1){break;}
        u_xlat6 = fma(u_xlat5, float4(u_xlat9), u_xlat6);
        u_xlat1.xy = fma(u_xlat1.wz, float2(0.5, 0.5), u_xlat6.wz);
        u_xlat1.x = u_xlat1.x / u_xlat1.y;
        u_xlatb10 = u_xlat18.x<u_xlat1.x;
        u_xlat18.x = (u_xlatb10) ? u_xlat18.x : u_xlat1.x;
        u_xlat1.xy = (bool(u_xlatb0)) ? u_xlat6.yx : u_xlat6.xy;
        u_xlat3.yz = u_xlat1.xy * FGlobals._Test_TexelSize.xy;
        u_xlat1.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat3.yz, level(0.0)).x;
        u_xlat1.x = fma(FGlobals._ZBufferParams.z, u_xlat1.x, FGlobals._ZBufferParams.w);
        u_xlat1.x = float(1.0) / u_xlat1.x;
        u_xlatb1 = u_xlat18.x<(-u_xlat1.x);
        u_xlat3.w = as_type<float>(u_xlati27 + 0x1);
        u_xlat8 = select(float4(0.0, 0.0, 0.0, 0.0), u_xlat3, bool4(bool4(u_xlatb1)));
        u_xlat4 = u_xlat8;
        u_xlat7 = u_xlat8;
        if(u_xlatb1){break;}
        u_xlatb8 = u_xlatb1;
        u_xlati27 = u_xlati27 + 0x1;
        u_xlat4.x = float(0.0);
        u_xlat4.y = float(0.0);
        u_xlat4.z = float(0.0);
        u_xlat4.w = float(0.0);
        u_xlat7.x = float(0.0);
        u_xlat7.y = float(0.0);
        u_xlat7.z = float(0.0);
        u_xlat7.w = float(0.0);
    }
    u_xlat0 = (as_type<int>(u_xlat8.x) != 0) ? u_xlat4 : u_xlat7;
    u_xlat27 = float(as_type<int>(u_xlat0.w));
    output.SV_Target0.z = u_xlat27 / FGlobals._Params2.w;
    output.SV_Target0.w = as_type<float>(as_type<uint>(u_xlat0.x) & 0x3f800000u);
    output.SV_Target0.xy = u_xlat0.yz;
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
    float3 _WorldSpaceCameraPos;
    float4 _ProjectionParams;
    float4 _ZBufferParams;
    float4 _Test_TexelSize;
    float4 hlslcc_mtx4x4_ViewMatrix[4];
    float4 hlslcc_mtx4x4_InverseProjectionMatrix[4];
    float4 hlslcc_mtx4x4_ScreenSpaceProjectionMatrix[4];
    float4 _Params;
    float4 _Params2;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (0) ]],
    sampler sampler_CameraGBufferTexture2 [[ sampler (1) ]],
    sampler sampler_Noise [[ sampler (2) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraGBufferTexture2 [[ texture(1) ]] ,
    texture2d<half, access::sample > _Noise [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    bool u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float4 u_xlat8;
    half u_xlat16_8;
    bool u_xlatb8;
    float u_xlat9;
    int u_xlati9;
    bool u_xlatb10;
    float2 u_xlat18;
    half u_xlat16_18;
    float u_xlat27;
    int u_xlati27;
    bool u_xlatb27;
    float u_xlat28;
    u_xlat16_0 = _CameraGBufferTexture2.sample(sampler_CameraGBufferTexture2, input.TEXCOORD1.xy);
    u_xlat27 = dot(float4(u_xlat16_0), float4(1.0, 1.0, 1.0, 1.0));
    u_xlatb27 = u_xlat27==0.0;
    if(u_xlatb27){
        output.SV_Target0 = float4(0.0, 0.0, 0.0, 0.0);
        return output;
    }
    u_xlat27 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD0.xy, level(0.0)).x;
    u_xlat1.xy = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat2 = u_xlat1.yyyy * FGlobals.hlslcc_mtx4x4_InverseProjectionMatrix[1];
    u_xlat1 = fma(FGlobals.hlslcc_mtx4x4_InverseProjectionMatrix[0], u_xlat1.xxxx, u_xlat2);
    u_xlat1 = fma(FGlobals.hlslcc_mtx4x4_InverseProjectionMatrix[2], float4(u_xlat27), u_xlat1);
    u_xlat1 = u_xlat1 + FGlobals.hlslcc_mtx4x4_InverseProjectionMatrix[3];
    u_xlat1.xyz = u_xlat1.xyz / u_xlat1.www;
    u_xlatb27 = u_xlat1.z<(-FGlobals._Params.z);
    if(u_xlatb27){
        output.SV_Target0 = float4(0.0, 0.0, 0.0, 0.0);
        return output;
    }
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat2.xyz = float3(u_xlat16_0.yyy) * FGlobals.hlslcc_mtx4x4_ViewMatrix[1].xyz;
    u_xlat0.xyw = fma(FGlobals.hlslcc_mtx4x4_ViewMatrix[0].xyz, float3(u_xlat16_0.xxx), u_xlat2.xyz);
    u_xlat0.xyz = fma(FGlobals.hlslcc_mtx4x4_ViewMatrix[2].xyz, float3(u_xlat16_0.zzz), u_xlat0.xyw);
    u_xlat27 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat2.xyz = float3(u_xlat27) * u_xlat1.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat0.xyz = fma(u_xlat0.xyz, (-float3(u_xlat27)), u_xlat2.xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlatb27 = 0.0<u_xlat0.z;
    if(u_xlatb27){
        output.SV_Target0 = float4(0.0, 0.0, 0.0, 0.0);
        return output;
    }
    u_xlat27 = fma(u_xlat0.z, FGlobals._Params.z, u_xlat1.z);
    u_xlatb27 = (-FGlobals._ProjectionParams.y)<u_xlat27;
    u_xlat28 = (-u_xlat1.z) + (-FGlobals._ProjectionParams.y);
    u_xlat28 = u_xlat28 / u_xlat0.z;
    u_xlat27 = (u_xlatb27) ? u_xlat28 : FGlobals._Params.z;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat27), u_xlat1.xyz);
    u_xlat2.xyz = u_xlat1.zzz * FGlobals.hlslcc_mtx4x4_ScreenSpaceProjectionMatrix[2].xyw;
    u_xlat3.z = fma(FGlobals.hlslcc_mtx4x4_ScreenSpaceProjectionMatrix[0].x, u_xlat1.x, u_xlat2.x);
    u_xlat3.w = fma(FGlobals.hlslcc_mtx4x4_ScreenSpaceProjectionMatrix[1].y, u_xlat1.y, u_xlat2.y);
    u_xlat1.xyw = u_xlat0.zzz * FGlobals.hlslcc_mtx4x4_ScreenSpaceProjectionMatrix[2].xyw;
    u_xlat3.x = fma(FGlobals.hlslcc_mtx4x4_ScreenSpaceProjectionMatrix[0].x, u_xlat0.x, u_xlat1.x);
    u_xlat3.y = fma(FGlobals.hlslcc_mtx4x4_ScreenSpaceProjectionMatrix[1].y, u_xlat0.y, u_xlat1.y);
    u_xlat2.zw = float2(1.0) / float2(u_xlat2.zz);
    u_xlat2.xy = float2(1.0) / float2(u_xlat1.ww);
    u_xlat4.w = u_xlat1.z * u_xlat2.w;
    u_xlat5 = u_xlat2.wzxy * u_xlat3.wzxy;
    u_xlat0.xy = fma(u_xlat3.zw, u_xlat2.zw, (-u_xlat5.zw));
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlatb0 = 9.99999975e-05>=u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat9 = max(FGlobals._Test_TexelSize.y, FGlobals._Test_TexelSize.x);
    u_xlat0.xy = fma(u_xlat0.xx, float2(u_xlat9), u_xlat5.wz);
    u_xlat5.zw = fma((-u_xlat3.wz), u_xlat2.wz, u_xlat0.xy);
    u_xlatb0 = abs(u_xlat5.w)<abs(u_xlat5.z);
    u_xlat3 = (bool(u_xlatb0)) ? u_xlat5 : u_xlat5.yxwz;
    u_xlati9 = int((0.0<u_xlat3.z) ? 0xFFFFFFFFu : uint(0));
    u_xlati27 = int((u_xlat3.z<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati9 = (-u_xlati9) + u_xlati27;
    u_xlat5.x = float(u_xlati9);
    u_xlat9 = u_xlat5.x / u_xlat3.z;
    u_xlat18.x = fma(u_xlat0.z, u_xlat2.y, (-u_xlat4.w));
    u_xlat5.w = u_xlat9 * u_xlat18.x;
    u_xlat5.y = u_xlat9 * u_xlat3.w;
    u_xlat18.x = (-u_xlat2.w) + u_xlat2.y;
    u_xlat5.z = u_xlat9 * u_xlat18.x;
    u_xlat9 = u_xlat1.z * -0.00999999978;
    u_xlat9 = min(u_xlat9, 1.0);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat1.xy = input.TEXCOORD0.xy * FGlobals._Params2.yy;
    u_xlat1.z = u_xlat1.y * FGlobals._Params2.x;
    u_xlat18.xy = u_xlat1.xz + FGlobals._WorldSpaceCameraPos.xyzx.xz;
    u_xlat16_18 = _Noise.sample(sampler_Noise, u_xlat18.xy, level(0.0)).w;
    u_xlat9 = u_xlat9 * FGlobals._Params2.z;
    u_xlat1 = float4(u_xlat9) * u_xlat5;
    u_xlat4.xy = u_xlat3.xy;
    u_xlat4.z = u_xlat2.w;
    u_xlat2 = fma(u_xlat1, float4(u_xlat16_18), u_xlat4);
    u_xlat3.x = as_type<float>(int(0xffffffffu));
    u_xlat4.x = float(0.0);
    u_xlat4.y = float(0.0);
    u_xlat4.z = float(0.0);
    u_xlat4.w = float(0.0);
    u_xlat6 = u_xlat2;
    u_xlat7.x = float(0.0);
    u_xlat7.y = float(0.0);
    u_xlat7.z = float(0.0);
    u_xlat7.w = float(0.0);
    u_xlat18.x = float(0.0);
    u_xlati27 = int(0x0);
    u_xlat16_8 = half(0.0);
    while(true){
        u_xlat1.x = float(u_xlati27);
        u_xlatb1 = u_xlat1.x>=FGlobals._Params2.w;
        u_xlat8.x = 0.0;
        if(u_xlatb1){break;}
        u_xlat6 = fma(u_xlat5, float4(u_xlat9), u_xlat6);
        u_xlat1.xy = fma(u_xlat1.wz, float2(0.5, 0.5), u_xlat6.wz);
        u_xlat1.x = u_xlat1.x / u_xlat1.y;
        u_xlatb10 = u_xlat18.x<u_xlat1.x;
        u_xlat18.x = (u_xlatb10) ? u_xlat18.x : u_xlat1.x;
        u_xlat1.xy = (bool(u_xlatb0)) ? u_xlat6.yx : u_xlat6.xy;
        u_xlat3.yz = u_xlat1.xy * FGlobals._Test_TexelSize.xy;
        u_xlat1.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat3.yz, level(0.0)).x;
        u_xlat1.x = fma(FGlobals._ZBufferParams.z, u_xlat1.x, FGlobals._ZBufferParams.w);
        u_xlat1.x = float(1.0) / u_xlat1.x;
        u_xlatb1 = u_xlat18.x<(-u_xlat1.x);
        u_xlat3.w = as_type<float>(u_xlati27 + 0x1);
        u_xlat8 = select(float4(0.0, 0.0, 0.0, 0.0), u_xlat3, bool4(bool4(u_xlatb1)));
        u_xlat4 = u_xlat8;
        u_xlat7 = u_xlat8;
        if(u_xlatb1){break;}
        u_xlatb8 = u_xlatb1;
        u_xlati27 = u_xlati27 + 0x1;
        u_xlat4.x = float(0.0);
        u_xlat4.y = float(0.0);
        u_xlat4.z = float(0.0);
        u_xlat4.w = float(0.0);
        u_xlat7.x = float(0.0);
        u_xlat7.y = float(0.0);
        u_xlat7.z = float(0.0);
        u_xlat7.w = float(0.0);
    }
    u_xlat0 = (as_type<int>(u_xlat8.x) != 0) ? u_xlat4 : u_xlat7;
    u_xlat27 = float(as_type<int>(u_xlat0.w));
    output.SV_Target0.z = u_xlat27 / FGlobals._Params2.w;
    output.SV_Target0.w = as_type<float>(as_type<uint>(u_xlat0.x) & 0x3f800000u);
    output.SV_Target0.xy = u_xlat0.yz;
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
    float3 _WorldSpaceCameraPos;
    float4 _ProjectionParams;
    float4 _ZBufferParams;
    float4 _Test_TexelSize;
    float4 hlslcc_mtx4x4_ViewMatrix[4];
    float4 hlslcc_mtx4x4_InverseProjectionMatrix[4];
    float4 hlslcc_mtx4x4_ScreenSpaceProjectionMatrix[4];
    float4 _Params;
    float4 _Params2;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (0) ]],
    sampler sampler_CameraGBufferTexture2 [[ sampler (1) ]],
    sampler sampler_Noise [[ sampler (2) ]],
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(0) ]] ,
    texture2d<half, access::sample > _CameraGBufferTexture2 [[ texture(1) ]] ,
    texture2d<half, access::sample > _Noise [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    bool u_xlatb0;
    float4 u_xlat1;
    bool u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float4 u_xlat8;
    half u_xlat16_8;
    bool u_xlatb8;
    float u_xlat9;
    int u_xlati9;
    bool u_xlatb10;
    float2 u_xlat18;
    half u_xlat16_18;
    float u_xlat27;
    int u_xlati27;
    bool u_xlatb27;
    float u_xlat28;
    u_xlat16_0 = _CameraGBufferTexture2.sample(sampler_CameraGBufferTexture2, input.TEXCOORD1.xy);
    u_xlat27 = dot(float4(u_xlat16_0), float4(1.0, 1.0, 1.0, 1.0));
    u_xlatb27 = u_xlat27==0.0;
    if(u_xlatb27){
        output.SV_Target0 = float4(0.0, 0.0, 0.0, 0.0);
        return output;
    }
    u_xlat27 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD0.xy, level(0.0)).x;
    u_xlat1.xy = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat2 = u_xlat1.yyyy * FGlobals.hlslcc_mtx4x4_InverseProjectionMatrix[1];
    u_xlat1 = fma(FGlobals.hlslcc_mtx4x4_InverseProjectionMatrix[0], u_xlat1.xxxx, u_xlat2);
    u_xlat1 = fma(FGlobals.hlslcc_mtx4x4_InverseProjectionMatrix[2], float4(u_xlat27), u_xlat1);
    u_xlat1 = u_xlat1 + FGlobals.hlslcc_mtx4x4_InverseProjectionMatrix[3];
    u_xlat1.xyz = u_xlat1.xyz / u_xlat1.www;
    u_xlatb27 = u_xlat1.z<(-FGlobals._Params.z);
    if(u_xlatb27){
        output.SV_Target0 = float4(0.0, 0.0, 0.0, 0.0);
        return output;
    }
    u_xlat16_0.xyz = fma(u_xlat16_0.xyz, half3(2.0, 2.0, 2.0), half3(-1.0, -1.0, -1.0));
    u_xlat2.xyz = float3(u_xlat16_0.yyy) * FGlobals.hlslcc_mtx4x4_ViewMatrix[1].xyz;
    u_xlat0.xyw = fma(FGlobals.hlslcc_mtx4x4_ViewMatrix[0].xyz, float3(u_xlat16_0.xxx), u_xlat2.xyz);
    u_xlat0.xyz = fma(FGlobals.hlslcc_mtx4x4_ViewMatrix[2].xyz, float3(u_xlat16_0.zzz), u_xlat0.xyw);
    u_xlat27 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat2.xyz = float3(u_xlat27) * u_xlat1.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat0.xyz = fma(u_xlat0.xyz, (-float3(u_xlat27)), u_xlat2.xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlatb27 = 0.0<u_xlat0.z;
    if(u_xlatb27){
        output.SV_Target0 = float4(0.0, 0.0, 0.0, 0.0);
        return output;
    }
    u_xlat27 = fma(u_xlat0.z, FGlobals._Params.z, u_xlat1.z);
    u_xlatb27 = (-FGlobals._ProjectionParams.y)<u_xlat27;
    u_xlat28 = (-u_xlat1.z) + (-FGlobals._ProjectionParams.y);
    u_xlat28 = u_xlat28 / u_xlat0.z;
    u_xlat27 = (u_xlatb27) ? u_xlat28 : FGlobals._Params.z;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat27), u_xlat1.xyz);
    u_xlat2.xyz = u_xlat1.zzz * FGlobals.hlslcc_mtx4x4_ScreenSpaceProjectionMatrix[2].xyw;
    u_xlat3.z = fma(FGlobals.hlslcc_mtx4x4_ScreenSpaceProjectionMatrix[0].x, u_xlat1.x, u_xlat2.x);
    u_xlat3.w = fma(FGlobals.hlslcc_mtx4x4_ScreenSpaceProjectionMatrix[1].y, u_xlat1.y, u_xlat2.y);
    u_xlat1.xyw = u_xlat0.zzz * FGlobals.hlslcc_mtx4x4_ScreenSpaceProjectionMatrix[2].xyw;
    u_xlat3.x = fma(FGlobals.hlslcc_mtx4x4_ScreenSpaceProjectionMatrix[0].x, u_xlat0.x, u_xlat1.x);
    u_xlat3.y = fma(FGlobals.hlslcc_mtx4x4_ScreenSpaceProjectionMatrix[1].y, u_xlat0.y, u_xlat1.y);
    u_xlat2.zw = float2(1.0) / float2(u_xlat2.zz);
    u_xlat2.xy = float2(1.0) / float2(u_xlat1.ww);
    u_xlat4.w = u_xlat1.z * u_xlat2.w;
    u_xlat5 = u_xlat2.wzxy * u_xlat3.wzxy;
    u_xlat0.xy = fma(u_xlat3.zw, u_xlat2.zw, (-u_xlat5.zw));
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlatb0 = 9.99999975e-05>=u_xlat0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat9 = max(FGlobals._Test_TexelSize.y, FGlobals._Test_TexelSize.x);
    u_xlat0.xy = fma(u_xlat0.xx, float2(u_xlat9), u_xlat5.wz);
    u_xlat5.zw = fma((-u_xlat3.wz), u_xlat2.wz, u_xlat0.xy);
    u_xlatb0 = abs(u_xlat5.w)<abs(u_xlat5.z);
    u_xlat3 = (bool(u_xlatb0)) ? u_xlat5 : u_xlat5.yxwz;
    u_xlati9 = int((0.0<u_xlat3.z) ? 0xFFFFFFFFu : uint(0));
    u_xlati27 = int((u_xlat3.z<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati9 = (-u_xlati9) + u_xlati27;
    u_xlat5.x = float(u_xlati9);
    u_xlat9 = u_xlat5.x / u_xlat3.z;
    u_xlat18.x = fma(u_xlat0.z, u_xlat2.y, (-u_xlat4.w));
    u_xlat5.w = u_xlat9 * u_xlat18.x;
    u_xlat5.y = u_xlat9 * u_xlat3.w;
    u_xlat18.x = (-u_xlat2.w) + u_xlat2.y;
    u_xlat5.z = u_xlat9 * u_xlat18.x;
    u_xlat9 = u_xlat1.z * -0.00999999978;
    u_xlat9 = min(u_xlat9, 1.0);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat1.xy = input.TEXCOORD0.xy * FGlobals._Params2.yy;
    u_xlat1.z = u_xlat1.y * FGlobals._Params2.x;
    u_xlat18.xy = u_xlat1.xz + FGlobals._WorldSpaceCameraPos.xyzx.xz;
    u_xlat16_18 = _Noise.sample(sampler_Noise, u_xlat18.xy, level(0.0)).w;
    u_xlat9 = u_xlat9 * FGlobals._Params2.z;
    u_xlat1 = float4(u_xlat9) * u_xlat5;
    u_xlat4.xy = u_xlat3.xy;
    u_xlat4.z = u_xlat2.w;
    u_xlat2 = fma(u_xlat1, float4(u_xlat16_18), u_xlat4);
    u_xlat3.x = as_type<float>(int(0xffffffffu));
    u_xlat4.x = float(0.0);
    u_xlat4.y = float(0.0);
    u_xlat4.z = float(0.0);
    u_xlat4.w = float(0.0);
    u_xlat6 = u_xlat2;
    u_xlat7.x = float(0.0);
    u_xlat7.y = float(0.0);
    u_xlat7.z = float(0.0);
    u_xlat7.w = float(0.0);
    u_xlat18.x = float(0.0);
    u_xlati27 = int(0x0);
    u_xlat16_8 = half(0.0);
    while(true){
        u_xlat1.x = float(u_xlati27);
        u_xlatb1 = u_xlat1.x>=FGlobals._Params2.w;
        u_xlat8.x = 0.0;
        if(u_xlatb1){break;}
        u_xlat6 = fma(u_xlat5, float4(u_xlat9), u_xlat6);
        u_xlat1.xy = fma(u_xlat1.wz, float2(0.5, 0.5), u_xlat6.wz);
        u_xlat1.x = u_xlat1.x / u_xlat1.y;
        u_xlatb10 = u_xlat18.x<u_xlat1.x;
        u_xlat18.x = (u_xlatb10) ? u_xlat18.x : u_xlat1.x;
        u_xlat1.xy = (bool(u_xlatb0)) ? u_xlat6.yx : u_xlat6.xy;
        u_xlat3.yz = u_xlat1.xy * FGlobals._Test_TexelSize.xy;
        u_xlat1.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, u_xlat3.yz, level(0.0)).x;
        u_xlat1.x = fma(FGlobals._ZBufferParams.z, u_xlat1.x, FGlobals._ZBufferParams.w);
        u_xlat1.x = float(1.0) / u_xlat1.x;
        u_xlatb1 = u_xlat18.x<(-u_xlat1.x);
        u_xlat3.w = as_type<float>(u_xlati27 + 0x1);
        u_xlat8 = select(float4(0.0, 0.0, 0.0, 0.0), u_xlat3, bool4(bool4(u_xlatb1)));
        u_xlat4 = u_xlat8;
        u_xlat7 = u_xlat8;
        if(u_xlatb1){break;}
        u_xlatb8 = u_xlatb1;
        u_xlati27 = u_xlati27 + 0x1;
        u_xlat4.x = float(0.0);
        u_xlat4.y = float(0.0);
        u_xlat4.z = float(0.0);
        u_xlat4.w = float(0.0);
        u_xlat7.x = float(0.0);
        u_xlat7.y = float(0.0);
        u_xlat7.z = float(0.0);
        u_xlat7.w = float(0.0);
    }
    u_xlat0 = (as_type<int>(u_xlat8.x) != 0) ? u_xlat4 : u_xlat7;
    u_xlat27 = float(as_type<int>(u_xlat0.w));
    output.SV_Target0.z = u_xlat27 / FGlobals._Params2.w;
    output.SV_Target0.w = as_type<float>(as_type<uint>(u_xlat0.x) & 0x3f800000u);
    output.SV_Target0.xy = u_xlat0.yz;
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
  GpuProgramID 101441
Program "vp" {
SubProgram "metal hw_tier00 " {
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

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
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 phase0_Output0_1;
    float4 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0 = input.POSITION0.xyxy + float4(1.0, 1.0, 1.0, 1.0);
    phase0_Output0_1 = fma(u_xlat0, float4(0.5, -0.5, 0.5, -0.5), float4(0.0, 1.0, 0.0, 1.0));
    output.TEXCOORD0 = phase0_Output0_1.xy;
    output.TEXCOORD1 = phase0_Output0_1.zw;
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
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 phase0_Output0_1;
    float4 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0 = input.POSITION0.xyxy + float4(1.0, 1.0, 1.0, 1.0);
    phase0_Output0_1 = fma(u_xlat0, float4(0.5, -0.5, 0.5, -0.5), float4(0.0, 1.0, 0.0, 1.0));
    output.TEXCOORD0 = phase0_Output0_1.xy;
    output.TEXCOORD1 = phase0_Output0_1.zw;
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
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 phase0_Output0_1;
    float4 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0 = input.POSITION0.xyxy + float4(1.0, 1.0, 1.0, 1.0);
    phase0_Output0_1 = fma(u_xlat0, float4(0.5, -0.5, 0.5, -0.5), float4(0.0, 1.0, 0.0, 1.0));
    output.TEXCOORD0 = phase0_Output0_1.xy;
    output.TEXCOORD1 = phase0_Output0_1.zw;
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
    float4 _Params;
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
    texture2d<half, access::sample > _Test [[ texture(1) ]] ,
    float4 mtl_FragCoord [[ position ]],
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 hlslcc_FragCoord = float4(mtl_FragCoord.xyz, 1.0/mtl_FragCoord.w);
    float4 u_xlat0;
    uint4 u_xlatu0;
    half3 u_xlat16_1;
    bool u_xlatb1;
    float3 u_xlat2;
    float u_xlat3;
    float u_xlat9;
    float u_xlat10;
    u_xlatu0.xy = uint2(int2(hlslcc_FragCoord.xy));
    u_xlatu0.z = uint(0x0u);
    u_xlatu0.w = uint(0x0u);
    u_xlat0 = float4(_Test.read(u_xlatu0.xy, u_xlatu0.w));
    u_xlatb1 = u_xlat0.w==0.0;
    if(u_xlatb1){
        output.SV_Target0 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy));
        return output;
    }
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0)).xyz;
    u_xlat10 = max(u_xlat0.y, u_xlat0.x);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat2.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat10 = min(u_xlat10, u_xlat2.x);
    u_xlat10 = u_xlat10 * 2.19178081;
    u_xlat10 = clamp(u_xlat10, 0.0f, 1.0f);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat10 = float(1.0) / u_xlat10;
    u_xlat9 = u_xlat0.w * u_xlat10;
    u_xlat0.xy = u_xlat0.xy + float2(-0.5, -0.5);
    u_xlat2.yz = abs(u_xlat0.xy) * FGlobals._Params.xx;
    u_xlat0.x = FGlobals._MainTex_TexelSize.z * FGlobals._MainTex_TexelSize.y;
    u_xlat2.x = u_xlat0.x * u_xlat2.y;
    u_xlat0.x = dot(u_xlat2.xz, u_xlat2.xz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat3 = u_xlat0.x * u_xlat0.x;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    output.SV_Target0.xyz = u_xlat0.xxx * float3(u_xlat16_1.xyz);
    output.SV_Target0.w = u_xlat0.z;
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
    float4 _Params;
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
    texture2d<half, access::sample > _Test [[ texture(1) ]] ,
    float4 mtl_FragCoord [[ position ]],
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 hlslcc_FragCoord = float4(mtl_FragCoord.xyz, 1.0/mtl_FragCoord.w);
    float4 u_xlat0;
    uint4 u_xlatu0;
    half3 u_xlat16_1;
    bool u_xlatb1;
    float3 u_xlat2;
    float u_xlat3;
    float u_xlat9;
    float u_xlat10;
    u_xlatu0.xy = uint2(int2(hlslcc_FragCoord.xy));
    u_xlatu0.z = uint(0x0u);
    u_xlatu0.w = uint(0x0u);
    u_xlat0 = float4(_Test.read(u_xlatu0.xy, u_xlatu0.w));
    u_xlatb1 = u_xlat0.w==0.0;
    if(u_xlatb1){
        output.SV_Target0 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy));
        return output;
    }
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0)).xyz;
    u_xlat10 = max(u_xlat0.y, u_xlat0.x);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat2.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat10 = min(u_xlat10, u_xlat2.x);
    u_xlat10 = u_xlat10 * 2.19178081;
    u_xlat10 = clamp(u_xlat10, 0.0f, 1.0f);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat10 = float(1.0) / u_xlat10;
    u_xlat9 = u_xlat0.w * u_xlat10;
    u_xlat0.xy = u_xlat0.xy + float2(-0.5, -0.5);
    u_xlat2.yz = abs(u_xlat0.xy) * FGlobals._Params.xx;
    u_xlat0.x = FGlobals._MainTex_TexelSize.z * FGlobals._MainTex_TexelSize.y;
    u_xlat2.x = u_xlat0.x * u_xlat2.y;
    u_xlat0.x = dot(u_xlat2.xz, u_xlat2.xz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat3 = u_xlat0.x * u_xlat0.x;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    output.SV_Target0.xyz = u_xlat0.xxx * float3(u_xlat16_1.xyz);
    output.SV_Target0.w = u_xlat0.z;
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
    float4 _Params;
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
    texture2d<half, access::sample > _Test [[ texture(1) ]] ,
    float4 mtl_FragCoord [[ position ]],
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 hlslcc_FragCoord = float4(mtl_FragCoord.xyz, 1.0/mtl_FragCoord.w);
    float4 u_xlat0;
    uint4 u_xlatu0;
    half3 u_xlat16_1;
    bool u_xlatb1;
    float3 u_xlat2;
    float u_xlat3;
    float u_xlat9;
    float u_xlat10;
    u_xlatu0.xy = uint2(int2(hlslcc_FragCoord.xy));
    u_xlatu0.z = uint(0x0u);
    u_xlatu0.w = uint(0x0u);
    u_xlat0 = float4(_Test.read(u_xlatu0.xy, u_xlatu0.w));
    u_xlatb1 = u_xlat0.w==0.0;
    if(u_xlatb1){
        output.SV_Target0 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy));
        return output;
    }
    u_xlat16_1.xyz = _MainTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0)).xyz;
    u_xlat10 = max(u_xlat0.y, u_xlat0.x);
    u_xlat10 = (-u_xlat10) + 1.0;
    u_xlat2.x = min(u_xlat0.y, u_xlat0.x);
    u_xlat10 = min(u_xlat10, u_xlat2.x);
    u_xlat10 = u_xlat10 * 2.19178081;
    u_xlat10 = clamp(u_xlat10, 0.0f, 1.0f);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat10 = float(1.0) / u_xlat10;
    u_xlat9 = u_xlat0.w * u_xlat10;
    u_xlat0.xy = u_xlat0.xy + float2(-0.5, -0.5);
    u_xlat2.yz = abs(u_xlat0.xy) * FGlobals._Params.xx;
    u_xlat0.x = FGlobals._MainTex_TexelSize.z * FGlobals._MainTex_TexelSize.y;
    u_xlat2.x = u_xlat0.x * u_xlat2.y;
    u_xlat0.x = dot(u_xlat2.xz, u_xlat2.xz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat3 = u_xlat0.x * u_xlat0.x;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    output.SV_Target0.xyz = u_xlat0.xxx * float3(u_xlat16_1.xyz);
    output.SV_Target0.w = u_xlat0.z;
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
  GpuProgramID 154502
Program "vp" {
SubProgram "metal hw_tier00 " {
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

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
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 phase0_Output0_1;
    float4 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0 = input.POSITION0.xyxy + float4(1.0, 1.0, 1.0, 1.0);
    phase0_Output0_1 = fma(u_xlat0, float4(0.5, -0.5, 0.5, -0.5), float4(0.0, 1.0, 0.0, 1.0));
    output.TEXCOORD0 = phase0_Output0_1.xy;
    output.TEXCOORD1 = phase0_Output0_1.zw;
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
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 phase0_Output0_1;
    float4 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0 = input.POSITION0.xyxy + float4(1.0, 1.0, 1.0, 1.0);
    phase0_Output0_1 = fma(u_xlat0, float4(0.5, -0.5, 0.5, -0.5), float4(0.0, 1.0, 0.0, 1.0));
    output.TEXCOORD0 = phase0_Output0_1.xy;
    output.TEXCOORD1 = phase0_Output0_1.zw;
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
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 phase0_Output0_1;
    float4 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0 = input.POSITION0.xyxy + float4(1.0, 1.0, 1.0, 1.0);
    phase0_Output0_1 = fma(u_xlat0, float4(0.5, -0.5, 0.5, -0.5), float4(0.0, 1.0, 0.0, 1.0));
    output.TEXCOORD0 = phase0_Output0_1.xy;
    output.TEXCOORD1 = phase0_Output0_1.zw;
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
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_History [[ sampler (1) ]],
    sampler sampler_CameraMotionVectorsTexture [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _History [[ texture(1) ]] ,
    texture2d<half, access::sample > _CameraMotionVectorsTexture [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float2 u_xlat3;
    half4 u_xlat16_3;
    half4 u_xlat16_4;
    float u_xlat6;
    float2 u_xlat13;
    u_xlat0.z = 0.0;
    u_xlat0.xyw = (-FGlobals._MainTex_TexelSize.xyy);
    u_xlat0 = u_xlat0 + input.TEXCOORD0.xyxy;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0));
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.zw, level(0.0));
    u_xlat16_2 = min(u_xlat16_0, u_xlat16_1);
    u_xlat16_0 = max(u_xlat16_0, u_xlat16_1);
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(1.0, -1.0, -1.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0));
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw, level(0.0));
    u_xlat16_2 = min(u_xlat16_2, u_xlat16_3);
    u_xlat16_0 = max(u_xlat16_0, u_xlat16_3);
    u_xlat3.x = (-FGlobals._MainTex_TexelSize.x);
    u_xlat3.y = float(0.0);
    u_xlat13.y = float(0.0);
    u_xlat3.xy = u_xlat3.xy + input.TEXCOORD0.xy;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat3.xy, level(0.0));
    u_xlat16_2 = min(u_xlat16_2, u_xlat16_4);
    u_xlat16_0 = max(u_xlat16_0, u_xlat16_4);
    u_xlat13.x = FGlobals._MainTex_TexelSize.x;
    u_xlat3.xy = u_xlat13.xy + input.TEXCOORD0.xy;
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat3.xy, level(0.0));
    u_xlat16_2 = min(u_xlat16_2, u_xlat16_3);
    u_xlat16_0 = max(u_xlat16_0, u_xlat16_3);
    u_xlat16_0 = max(u_xlat16_1, u_xlat16_0);
    u_xlat16_1 = min(u_xlat16_1, u_xlat16_2);
    u_xlat2.x = 0.0;
    u_xlat2.y = FGlobals._MainTex_TexelSize.y;
    u_xlat2.xy = u_xlat2.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0));
    u_xlat16_1 = min(u_xlat16_1, u_xlat16_2);
    u_xlat16_0 = max(u_xlat16_0, u_xlat16_2);
    u_xlat2.xy = input.TEXCOORD0.xy + FGlobals._MainTex_TexelSize.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0));
    u_xlat16_1 = min(u_xlat16_1, u_xlat16_2);
    u_xlat16_0 = max(u_xlat16_0, u_xlat16_2);
    u_xlat2 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy, level(0.0)));
    u_xlat1 = min(float4(u_xlat16_1), u_xlat2);
    u_xlat16_3.xy = _CameraMotionVectorsTexture.sample(sampler_CameraMotionVectorsTexture, input.TEXCOORD1.xy, level(0.0)).xy;
    u_xlat13.xy = (-float2(u_xlat16_3.xy)) + input.TEXCOORD0.xy;
    u_xlat16_3.x = dot(u_xlat16_3.xy, u_xlat16_3.xy);
    u_xlat16_3.x = sqrt(u_xlat16_3.x);
    u_xlat3.x = fma((-FGlobals._MainTex_TexelSize.z), 0.00200000009, float(u_xlat16_3.x));
    u_xlat16_4 = _History.sample(sampler_History, u_xlat13.xy, level(0.0));
    u_xlat1 = max(u_xlat1, float4(u_xlat16_4));
    u_xlat0 = max(float4(u_xlat16_0), u_xlat2);
    u_xlat0 = min(u_xlat0, u_xlat1);
    u_xlat1.x = FGlobals._MainTex_TexelSize.z * 0.00150000001;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat3.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat6 = fma(u_xlat1.x, -2.0, 3.0);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat6;
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat2.w = u_xlat1.x * 0.850000024;
    u_xlat1 = u_xlat0 + (-u_xlat2);
    u_xlat0.x = fma(u_xlat0.w, -25.0, 0.949999988);
    u_xlat0.x = max(u_xlat0.x, 0.699999988);
    u_xlat0.x = min(u_xlat0.x, 0.949999988);
    output.SV_Target0 = fma(u_xlat0.xxxx, u_xlat1, u_xlat2);
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
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_History [[ sampler (1) ]],
    sampler sampler_CameraMotionVectorsTexture [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _History [[ texture(1) ]] ,
    texture2d<half, access::sample > _CameraMotionVectorsTexture [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float2 u_xlat3;
    half4 u_xlat16_3;
    half4 u_xlat16_4;
    float u_xlat6;
    float2 u_xlat13;
    u_xlat0.z = 0.0;
    u_xlat0.xyw = (-FGlobals._MainTex_TexelSize.xyy);
    u_xlat0 = u_xlat0 + input.TEXCOORD0.xyxy;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0));
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.zw, level(0.0));
    u_xlat16_2 = min(u_xlat16_0, u_xlat16_1);
    u_xlat16_0 = max(u_xlat16_0, u_xlat16_1);
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(1.0, -1.0, -1.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0));
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw, level(0.0));
    u_xlat16_2 = min(u_xlat16_2, u_xlat16_3);
    u_xlat16_0 = max(u_xlat16_0, u_xlat16_3);
    u_xlat3.x = (-FGlobals._MainTex_TexelSize.x);
    u_xlat3.y = float(0.0);
    u_xlat13.y = float(0.0);
    u_xlat3.xy = u_xlat3.xy + input.TEXCOORD0.xy;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat3.xy, level(0.0));
    u_xlat16_2 = min(u_xlat16_2, u_xlat16_4);
    u_xlat16_0 = max(u_xlat16_0, u_xlat16_4);
    u_xlat13.x = FGlobals._MainTex_TexelSize.x;
    u_xlat3.xy = u_xlat13.xy + input.TEXCOORD0.xy;
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat3.xy, level(0.0));
    u_xlat16_2 = min(u_xlat16_2, u_xlat16_3);
    u_xlat16_0 = max(u_xlat16_0, u_xlat16_3);
    u_xlat16_0 = max(u_xlat16_1, u_xlat16_0);
    u_xlat16_1 = min(u_xlat16_1, u_xlat16_2);
    u_xlat2.x = 0.0;
    u_xlat2.y = FGlobals._MainTex_TexelSize.y;
    u_xlat2.xy = u_xlat2.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0));
    u_xlat16_1 = min(u_xlat16_1, u_xlat16_2);
    u_xlat16_0 = max(u_xlat16_0, u_xlat16_2);
    u_xlat2.xy = input.TEXCOORD0.xy + FGlobals._MainTex_TexelSize.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0));
    u_xlat16_1 = min(u_xlat16_1, u_xlat16_2);
    u_xlat16_0 = max(u_xlat16_0, u_xlat16_2);
    u_xlat2 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy, level(0.0)));
    u_xlat1 = min(float4(u_xlat16_1), u_xlat2);
    u_xlat16_3.xy = _CameraMotionVectorsTexture.sample(sampler_CameraMotionVectorsTexture, input.TEXCOORD1.xy, level(0.0)).xy;
    u_xlat13.xy = (-float2(u_xlat16_3.xy)) + input.TEXCOORD0.xy;
    u_xlat16_3.x = dot(u_xlat16_3.xy, u_xlat16_3.xy);
    u_xlat16_3.x = sqrt(u_xlat16_3.x);
    u_xlat3.x = fma((-FGlobals._MainTex_TexelSize.z), 0.00200000009, float(u_xlat16_3.x));
    u_xlat16_4 = _History.sample(sampler_History, u_xlat13.xy, level(0.0));
    u_xlat1 = max(u_xlat1, float4(u_xlat16_4));
    u_xlat0 = max(float4(u_xlat16_0), u_xlat2);
    u_xlat0 = min(u_xlat0, u_xlat1);
    u_xlat1.x = FGlobals._MainTex_TexelSize.z * 0.00150000001;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat3.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat6 = fma(u_xlat1.x, -2.0, 3.0);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat6;
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat2.w = u_xlat1.x * 0.850000024;
    u_xlat1 = u_xlat0 + (-u_xlat2);
    u_xlat0.x = fma(u_xlat0.w, -25.0, 0.949999988);
    u_xlat0.x = max(u_xlat0.x, 0.699999988);
    u_xlat0.x = min(u_xlat0.x, 0.949999988);
    output.SV_Target0 = fma(u_xlat0.xxxx, u_xlat1, u_xlat2);
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
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_History [[ sampler (1) ]],
    sampler sampler_CameraMotionVectorsTexture [[ sampler (2) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<half, access::sample > _History [[ texture(1) ]] ,
    texture2d<half, access::sample > _CameraMotionVectorsTexture [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    half4 u_xlat16_0;
    float4 u_xlat1;
    half4 u_xlat16_1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    float2 u_xlat3;
    half4 u_xlat16_3;
    half4 u_xlat16_4;
    float u_xlat6;
    float2 u_xlat13;
    u_xlat0.z = 0.0;
    u_xlat0.xyw = (-FGlobals._MainTex_TexelSize.xyy);
    u_xlat0 = u_xlat0 + input.TEXCOORD0.xyxy;
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat0.xy, level(0.0));
    u_xlat16_0 = _MainTex.sample(sampler_MainTex, u_xlat0.zw, level(0.0));
    u_xlat16_2 = min(u_xlat16_0, u_xlat16_1);
    u_xlat16_0 = max(u_xlat16_0, u_xlat16_1);
    u_xlat1 = fma(FGlobals._MainTex_TexelSize.xyxy, float4(1.0, -1.0, -1.0, 1.0), input.TEXCOORD0.xyxy);
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat1.xy, level(0.0));
    u_xlat16_1 = _MainTex.sample(sampler_MainTex, u_xlat1.zw, level(0.0));
    u_xlat16_2 = min(u_xlat16_2, u_xlat16_3);
    u_xlat16_0 = max(u_xlat16_0, u_xlat16_3);
    u_xlat3.x = (-FGlobals._MainTex_TexelSize.x);
    u_xlat3.y = float(0.0);
    u_xlat13.y = float(0.0);
    u_xlat3.xy = u_xlat3.xy + input.TEXCOORD0.xy;
    u_xlat16_4 = _MainTex.sample(sampler_MainTex, u_xlat3.xy, level(0.0));
    u_xlat16_2 = min(u_xlat16_2, u_xlat16_4);
    u_xlat16_0 = max(u_xlat16_0, u_xlat16_4);
    u_xlat13.x = FGlobals._MainTex_TexelSize.x;
    u_xlat3.xy = u_xlat13.xy + input.TEXCOORD0.xy;
    u_xlat16_3 = _MainTex.sample(sampler_MainTex, u_xlat3.xy, level(0.0));
    u_xlat16_2 = min(u_xlat16_2, u_xlat16_3);
    u_xlat16_0 = max(u_xlat16_0, u_xlat16_3);
    u_xlat16_0 = max(u_xlat16_1, u_xlat16_0);
    u_xlat16_1 = min(u_xlat16_1, u_xlat16_2);
    u_xlat2.x = 0.0;
    u_xlat2.y = FGlobals._MainTex_TexelSize.y;
    u_xlat2.xy = u_xlat2.xy + input.TEXCOORD0.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0));
    u_xlat16_1 = min(u_xlat16_1, u_xlat16_2);
    u_xlat16_0 = max(u_xlat16_0, u_xlat16_2);
    u_xlat2.xy = input.TEXCOORD0.xy + FGlobals._MainTex_TexelSize.xy;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, u_xlat2.xy, level(0.0));
    u_xlat16_1 = min(u_xlat16_1, u_xlat16_2);
    u_xlat16_0 = max(u_xlat16_0, u_xlat16_2);
    u_xlat2 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy, level(0.0)));
    u_xlat1 = min(float4(u_xlat16_1), u_xlat2);
    u_xlat16_3.xy = _CameraMotionVectorsTexture.sample(sampler_CameraMotionVectorsTexture, input.TEXCOORD1.xy, level(0.0)).xy;
    u_xlat13.xy = (-float2(u_xlat16_3.xy)) + input.TEXCOORD0.xy;
    u_xlat16_3.x = dot(u_xlat16_3.xy, u_xlat16_3.xy);
    u_xlat16_3.x = sqrt(u_xlat16_3.x);
    u_xlat3.x = fma((-FGlobals._MainTex_TexelSize.z), 0.00200000009, float(u_xlat16_3.x));
    u_xlat16_4 = _History.sample(sampler_History, u_xlat13.xy, level(0.0));
    u_xlat1 = max(u_xlat1, float4(u_xlat16_4));
    u_xlat0 = max(float4(u_xlat16_0), u_xlat2);
    u_xlat0 = min(u_xlat0, u_xlat1);
    u_xlat1.x = FGlobals._MainTex_TexelSize.z * 0.00150000001;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat3.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat6 = fma(u_xlat1.x, -2.0, 3.0);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat6;
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat2.w = u_xlat1.x * 0.850000024;
    u_xlat1 = u_xlat0 + (-u_xlat2);
    u_xlat0.x = fma(u_xlat0.w, -25.0, 0.949999988);
    u_xlat0.x = max(u_xlat0.x, 0.699999988);
    u_xlat0.x = min(u_xlat0.x, 0.949999988);
    output.SV_Target0 = fma(u_xlat0.xxxx, u_xlat1, u_xlat2);
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
  GpuProgramID 245549
Program "vp" {
SubProgram "metal hw_tier00 " {
"#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

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
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 phase0_Output0_1;
    float4 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0 = input.POSITION0.xyxy + float4(1.0, 1.0, 1.0, 1.0);
    phase0_Output0_1 = fma(u_xlat0, float4(0.5, -0.5, 0.5, -0.5), float4(0.0, 1.0, 0.0, 1.0));
    output.TEXCOORD0 = phase0_Output0_1.xy;
    output.TEXCOORD1 = phase0_Output0_1.zw;
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
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 phase0_Output0_1;
    float4 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0 = input.POSITION0.xyxy + float4(1.0, 1.0, 1.0, 1.0);
    phase0_Output0_1 = fma(u_xlat0, float4(0.5, -0.5, 0.5, -0.5), float4(0.0, 1.0, 0.0, 1.0));
    output.TEXCOORD0 = phase0_Output0_1.xy;
    output.TEXCOORD1 = phase0_Output0_1.zw;
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
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 phase0_Output0_1;
    float4 u_xlat0;
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlat0 = input.POSITION0.xyxy + float4(1.0, 1.0, 1.0, 1.0);
    phase0_Output0_1 = fma(u_xlat0, float4(0.5, -0.5, 0.5, -0.5), float4(0.0, 1.0, 0.0, 1.0));
    output.TEXCOORD0 = phase0_Output0_1.xy;
    output.TEXCOORD1 = phase0_Output0_1.zw;
    return output;
}
"
}
}
Program "fp" {
SubProgram "metal " {
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
    float4 _ZBufferParams;
    float4 hlslcc_mtx4x4_InverseViewMatrix[4];
    float4 hlslcc_mtx4x4_InverseProjectionMatrix[4];
    float4 _Params;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    sampler sampler_CameraReflectionsTexture [[ sampler (2) ]],
    sampler sampler_Resolve [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(1) ]] ,
    texture2d<half, access::sample > _CameraReflectionsTexture [[ texture(2) ]] ,
    texture2d<half, access::sample > _CameraGBufferTexture0 [[ texture(3) ]] ,
    texture2d<half, access::sample > _CameraGBufferTexture1 [[ texture(4) ]] ,
    texture2d<half, access::sample > _CameraGBufferTexture2 [[ texture(5) ]] ,
    texture2d<half, access::sample > _Resolve [[ texture(6) ]] ,
    float4 mtl_FragCoord [[ position ]],
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 hlslcc_FragCoord = float4(mtl_FragCoord.xyz, 1.0/mtl_FragCoord.w);
    float3 u_xlat0;
    uint4 u_xlatu0;
    bool u_xlatb0;
    float u_xlat1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    half3 u_xlat16_3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    float u_xlat5;
    half3 u_xlat16_6;
    float3 u_xlat7;
    half3 u_xlat16_7;
    half u_xlat16_8;
    half u_xlat16_9;
    half u_xlat16_14;
    float u_xlat18;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy, level(0.0)).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.x, u_xlat0.x, FGlobals._ZBufferParams.y);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlatb0 = 0.999000013<u_xlat0.x;
    if(u_xlatb0){
        output.SV_Target0 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy));
        return output;
    }
    u_xlatu0.xy = uint2(int2(hlslcc_FragCoord.xy));
    u_xlatu0.z = uint(0x0u);
    u_xlatu0.w = uint(0x0u);
    u_xlat1 = float(_CameraGBufferTexture0.read(u_xlatu0.xy, u_xlatu0.w).w);
    u_xlat2 = float4(_CameraGBufferTexture1.read(u_xlatu0.xy, u_xlatu0.w));
    u_xlat0.xyz = float3(_CameraGBufferTexture2.read(u_xlatu0.xy, u_xlatu0.w).xyz);
    u_xlat16_3.x = half(max(u_xlat2.y, u_xlat2.x));
    u_xlat16_3.x = half(max(u_xlat2.z, float(u_xlat16_3.x)));
    u_xlat16_3.x = (-u_xlat16_3.x) + half(1.0);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(2.0, 2.0, 2.0), float3(-1.0, -1.0, -1.0));
    u_xlat18 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD0.xy, level(0.0)).x;
    u_xlat7.xy = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat4 = u_xlat7.yyyy * FGlobals.hlslcc_mtx4x4_InverseProjectionMatrix[1];
    u_xlat4 = fma(FGlobals.hlslcc_mtx4x4_InverseProjectionMatrix[0], u_xlat7.xxxx, u_xlat4);
    u_xlat4 = fma(FGlobals.hlslcc_mtx4x4_InverseProjectionMatrix[2], float4(u_xlat18), u_xlat4);
    u_xlat4 = u_xlat4 + FGlobals.hlslcc_mtx4x4_InverseProjectionMatrix[3];
    u_xlat7.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat18 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat7.xyz = float3(u_xlat18) * u_xlat7.xyz;
    u_xlat4.xyz = u_xlat7.yyy * FGlobals.hlslcc_mtx4x4_InverseViewMatrix[1].xyz;
    u_xlat4.xyz = fma(FGlobals.hlslcc_mtx4x4_InverseViewMatrix[0].xyz, u_xlat7.xxx, u_xlat4.xyz);
    u_xlat7.xyz = fma(FGlobals.hlslcc_mtx4x4_InverseViewMatrix[2].xyz, u_xlat7.zzz, u_xlat4.xyz);
    u_xlat16_9 = half((-u_xlat2.w) + 1.0);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
    u_xlat18 = FGlobals._Params.w + -1.0;
    u_xlat18 = fma(float(u_xlat16_9), u_xlat18, 1.0);
    u_xlat16_4 = _Resolve.sample(sampler_Resolve, input.TEXCOORD1.xy, level(u_xlat18));
    u_xlat18 = dot((-u_xlat7.xyz), u_xlat0.xyz);
    u_xlat5 = u_xlat18 + u_xlat18;
    u_xlat0.xyz = fma(u_xlat0.xyz, (-float3(u_xlat5)), (-u_xlat7.xyz));
    u_xlat5 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = rsqrt(u_xlat5);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat5);
    u_xlat0.x = dot((-u_xlat7.xyz), u_xlat0.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat18 = u_xlat18;
    u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
    u_xlat16_9 = half((-u_xlat18) + 1.0);
    u_xlat16_6.x = u_xlat16_9 * u_xlat16_9;
    u_xlat16_6.x = u_xlat16_9 * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_9 * u_xlat16_6.x;
    u_xlat16_3.x = (-u_xlat16_3.x) + half(1.0);
    u_xlat16_3.x = half(u_xlat2.w + float(u_xlat16_3.x));
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0h, 1.0h);
    u_xlat16_3.xyz = half3((-u_xlat2.xyz) + float3(u_xlat16_3.xxx));
    u_xlat16_3.xyz = half3(fma(float3(u_xlat16_6.xxx), float3(u_xlat16_3.xyz), u_xlat2.xyz));
    u_xlat16_6.xyz = _CameraReflectionsTexture.sample(sampler_CameraReflectionsTexture, input.TEXCOORD1.xy).xyz;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy);
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_2.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_2.x = u_xlat16_4.w * u_xlat16_4.w;
    u_xlat16_8 = u_xlat16_2.x * half(3.0);
    u_xlat16_2.x = fma(u_xlat16_2.x, half(3.0), half(-0.5));
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0h, 1.0h);
    u_xlat16_14 = fma(u_xlat16_2.x, half(-2.0), half(3.0));
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_14;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_8;
    u_xlat2.x = float(u_xlat16_2.x) * FGlobals._Params.y;
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat16_2.xyz = fma(u_xlat16_4.xyz, u_xlat16_3.xyz, (-u_xlat16_6.xyz));
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_2.xyz), float3(u_xlat16_6.xyz));
    output.SV_Target0.xyz = fma(u_xlat0.xyz, float3(u_xlat1), float3(u_xlat16_7.xyz));
    output.SV_Target0.w = float(u_xlat16_2.w);
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
    float4 _ZBufferParams;
    float4 hlslcc_mtx4x4_InverseViewMatrix[4];
    float4 hlslcc_mtx4x4_InverseProjectionMatrix[4];
    float4 _Params;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    sampler sampler_CameraReflectionsTexture [[ sampler (2) ]],
    sampler sampler_Resolve [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(1) ]] ,
    texture2d<half, access::sample > _CameraReflectionsTexture [[ texture(2) ]] ,
    texture2d<half, access::sample > _CameraGBufferTexture0 [[ texture(3) ]] ,
    texture2d<half, access::sample > _CameraGBufferTexture1 [[ texture(4) ]] ,
    texture2d<half, access::sample > _CameraGBufferTexture2 [[ texture(5) ]] ,
    texture2d<half, access::sample > _Resolve [[ texture(6) ]] ,
    float4 mtl_FragCoord [[ position ]],
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 hlslcc_FragCoord = float4(mtl_FragCoord.xyz, 1.0/mtl_FragCoord.w);
    float3 u_xlat0;
    uint4 u_xlatu0;
    bool u_xlatb0;
    float u_xlat1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    half u_xlat16_3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    float u_xlat5;
    half3 u_xlat16_6;
    float u_xlat7;
    half3 u_xlat16_7;
    float3 u_xlat8;
    half3 u_xlat16_8;
    half u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_13;
    float u_xlat14;
    half u_xlat16_16;
    float u_xlat21;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy, level(0.0)).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.x, u_xlat0.x, FGlobals._ZBufferParams.y);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlatb0 = 0.999000013<u_xlat0.x;
    if(u_xlatb0){
        output.SV_Target0 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy));
        return output;
    }
    u_xlatu0.xy = uint2(int2(hlslcc_FragCoord.xy));
    u_xlatu0.z = uint(0x0u);
    u_xlatu0.w = uint(0x0u);
    u_xlat1 = float(_CameraGBufferTexture0.read(u_xlatu0.xy, u_xlatu0.w).w);
    u_xlat2 = float4(_CameraGBufferTexture1.read(u_xlatu0.xy, u_xlatu0.w));
    u_xlat0.xyz = float3(_CameraGBufferTexture2.read(u_xlatu0.xy, u_xlatu0.w).xyz);
    u_xlat16_3 = half(max(u_xlat2.y, u_xlat2.x));
    u_xlat16_3 = half(max(u_xlat2.z, float(u_xlat16_3)));
    u_xlat16_3 = (-u_xlat16_3) + half(1.0);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(2.0, 2.0, 2.0), float3(-1.0, -1.0, -1.0));
    u_xlat21 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD0.xy, level(0.0)).x;
    u_xlat8.xy = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat4 = u_xlat8.yyyy * FGlobals.hlslcc_mtx4x4_InverseProjectionMatrix[1];
    u_xlat4 = fma(FGlobals.hlslcc_mtx4x4_InverseProjectionMatrix[0], u_xlat8.xxxx, u_xlat4);
    u_xlat4 = fma(FGlobals.hlslcc_mtx4x4_InverseProjectionMatrix[2], float4(u_xlat21), u_xlat4);
    u_xlat4 = u_xlat4 + FGlobals.hlslcc_mtx4x4_InverseProjectionMatrix[3];
    u_xlat8.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat21 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat8.xyz = float3(u_xlat21) * u_xlat8.xyz;
    u_xlat4.xyz = u_xlat8.yyy * FGlobals.hlslcc_mtx4x4_InverseViewMatrix[1].xyz;
    u_xlat4.xyz = fma(FGlobals.hlslcc_mtx4x4_InverseViewMatrix[0].xyz, u_xlat8.xxx, u_xlat4.xyz);
    u_xlat8.xyz = fma(FGlobals.hlslcc_mtx4x4_InverseViewMatrix[2].xyz, u_xlat8.zzz, u_xlat4.xyz);
    u_xlat16_10.x = half((-u_xlat2.w) + 1.0);
    u_xlat16_10.x = u_xlat16_10.x * u_xlat16_10.x;
    u_xlat21 = FGlobals._Params.w + -1.0;
    u_xlat21 = fma(float(u_xlat16_10.x), u_xlat21, 1.0);
    u_xlat16_4 = _Resolve.sample(sampler_Resolve, input.TEXCOORD1.xy, level(u_xlat21));
    u_xlat21 = dot((-u_xlat8.xyz), u_xlat0.xyz);
    u_xlat5 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = fma(u_xlat0.xyz, (-float3(u_xlat5)), (-u_xlat8.xyz));
    u_xlat5 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = rsqrt(u_xlat5);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat5);
    u_xlat0.x = dot((-u_xlat8.xyz), u_xlat0.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat21 = u_xlat21;
    u_xlat21 = clamp(u_xlat21, 0.0f, 1.0f);
    u_xlat7 = (-u_xlat2.w) + 1.0;
    u_xlat14 = u_xlat7 * u_xlat7;
    u_xlat16_10.x = half(u_xlat7 * u_xlat14);
    u_xlat16_10.x = fma((-u_xlat16_10.x), half(0.280000001), half(1.0));
    u_xlat16_3 = (-u_xlat16_3) + half(1.0);
    u_xlat16_3 = half(u_xlat2.w + float(u_xlat16_3));
    u_xlat16_3 = clamp(u_xlat16_3, 0.0h, 1.0h);
    u_xlat16_10.xyz = u_xlat16_4.xyz * u_xlat16_10.xxx;
    u_xlat16_6.x = half((-u_xlat21) + 1.0);
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_13.xyz = half3((-u_xlat2.xyz) + float3(u_xlat16_3));
    u_xlat16_6.xyz = half3(fma(float3(u_xlat16_6.xxx), float3(u_xlat16_13.xyz), u_xlat2.xyz));
    u_xlat16_7.xyz = _CameraReflectionsTexture.sample(sampler_CameraReflectionsTexture, input.TEXCOORD1.xy).xyz;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_2.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_2.x = u_xlat16_4.w * u_xlat16_4.w;
    u_xlat16_9 = u_xlat16_2.x * half(3.0);
    u_xlat16_2.x = fma(u_xlat16_2.x, half(3.0), half(-0.5));
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0h, 1.0h);
    u_xlat16_16 = fma(u_xlat16_2.x, half(-2.0), half(3.0));
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_16;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_9;
    u_xlat2.x = float(u_xlat16_2.x) * FGlobals._Params.y;
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat16_2.xyz = fma(u_xlat16_10.xyz, u_xlat16_6.xyz, (-u_xlat16_7.xyz));
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_2.xyz), float3(u_xlat16_7.xyz));
    output.SV_Target0.xyz = fma(u_xlat0.xyz, float3(u_xlat1), float3(u_xlat16_8.xyz));
    output.SV_Target0.w = float(u_xlat16_2.w);
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
    float4 _ZBufferParams;
    float4 hlslcc_mtx4x4_InverseViewMatrix[4];
    float4 hlslcc_mtx4x4_InverseProjectionMatrix[4];
    float4 _Params;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float2 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    sampler sampler_CameraDepthTexture [[ sampler (1) ]],
    sampler sampler_CameraReflectionsTexture [[ sampler (2) ]],
    sampler sampler_Resolve [[ sampler (3) ]],
    texture2d<half, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > _CameraDepthTexture [[ texture(1) ]] ,
    texture2d<half, access::sample > _CameraReflectionsTexture [[ texture(2) ]] ,
    texture2d<half, access::sample > _CameraGBufferTexture0 [[ texture(3) ]] ,
    texture2d<half, access::sample > _CameraGBufferTexture1 [[ texture(4) ]] ,
    texture2d<half, access::sample > _CameraGBufferTexture2 [[ texture(5) ]] ,
    texture2d<half, access::sample > _Resolve [[ texture(6) ]] ,
    float4 mtl_FragCoord [[ position ]],
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 hlslcc_FragCoord = float4(mtl_FragCoord.xyz, 1.0/mtl_FragCoord.w);
    float3 u_xlat0;
    uint4 u_xlatu0;
    bool u_xlatb0;
    float u_xlat1;
    float4 u_xlat2;
    half4 u_xlat16_2;
    half u_xlat16_3;
    float4 u_xlat4;
    half4 u_xlat16_4;
    float u_xlat5;
    half3 u_xlat16_6;
    float u_xlat7;
    half3 u_xlat16_7;
    float3 u_xlat8;
    half3 u_xlat16_8;
    half u_xlat16_9;
    half3 u_xlat16_10;
    half3 u_xlat16_13;
    float u_xlat14;
    half u_xlat16_16;
    float u_xlat21;
    u_xlat0.x = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD1.xy, level(0.0)).x;
    u_xlat0.x = fma(FGlobals._ZBufferParams.x, u_xlat0.x, FGlobals._ZBufferParams.y);
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlatb0 = 0.999000013<u_xlat0.x;
    if(u_xlatb0){
        output.SV_Target0 = float4(_MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy));
        return output;
    }
    u_xlatu0.xy = uint2(int2(hlslcc_FragCoord.xy));
    u_xlatu0.z = uint(0x0u);
    u_xlatu0.w = uint(0x0u);
    u_xlat1 = float(_CameraGBufferTexture0.read(u_xlatu0.xy, u_xlatu0.w).w);
    u_xlat2 = float4(_CameraGBufferTexture1.read(u_xlatu0.xy, u_xlatu0.w));
    u_xlat0.xyz = float3(_CameraGBufferTexture2.read(u_xlatu0.xy, u_xlatu0.w).xyz);
    u_xlat16_3 = half(max(u_xlat2.y, u_xlat2.x));
    u_xlat16_3 = half(max(u_xlat2.z, float(u_xlat16_3)));
    u_xlat16_3 = (-u_xlat16_3) + half(1.0);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(2.0, 2.0, 2.0), float3(-1.0, -1.0, -1.0));
    u_xlat21 = _CameraDepthTexture.sample(sampler_CameraDepthTexture, input.TEXCOORD0.xy, level(0.0)).x;
    u_xlat8.xy = fma(input.TEXCOORD0.xy, float2(2.0, 2.0), float2(-1.0, -1.0));
    u_xlat4 = u_xlat8.yyyy * FGlobals.hlslcc_mtx4x4_InverseProjectionMatrix[1];
    u_xlat4 = fma(FGlobals.hlslcc_mtx4x4_InverseProjectionMatrix[0], u_xlat8.xxxx, u_xlat4);
    u_xlat4 = fma(FGlobals.hlslcc_mtx4x4_InverseProjectionMatrix[2], float4(u_xlat21), u_xlat4);
    u_xlat4 = u_xlat4 + FGlobals.hlslcc_mtx4x4_InverseProjectionMatrix[3];
    u_xlat8.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat21 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat8.xyz = float3(u_xlat21) * u_xlat8.xyz;
    u_xlat4.xyz = u_xlat8.yyy * FGlobals.hlslcc_mtx4x4_InverseViewMatrix[1].xyz;
    u_xlat4.xyz = fma(FGlobals.hlslcc_mtx4x4_InverseViewMatrix[0].xyz, u_xlat8.xxx, u_xlat4.xyz);
    u_xlat8.xyz = fma(FGlobals.hlslcc_mtx4x4_InverseViewMatrix[2].xyz, u_xlat8.zzz, u_xlat4.xyz);
    u_xlat16_10.x = half((-u_xlat2.w) + 1.0);
    u_xlat16_10.x = u_xlat16_10.x * u_xlat16_10.x;
    u_xlat21 = FGlobals._Params.w + -1.0;
    u_xlat21 = fma(float(u_xlat16_10.x), u_xlat21, 1.0);
    u_xlat16_4 = _Resolve.sample(sampler_Resolve, input.TEXCOORD1.xy, level(u_xlat21));
    u_xlat21 = dot((-u_xlat8.xyz), u_xlat0.xyz);
    u_xlat5 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = fma(u_xlat0.xyz, (-float3(u_xlat5)), (-u_xlat8.xyz));
    u_xlat5 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat5 = rsqrt(u_xlat5);
    u_xlat0.xyz = u_xlat0.xyz * float3(u_xlat5);
    u_xlat0.x = dot((-u_xlat8.xyz), u_xlat0.xyz);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat21 = u_xlat21;
    u_xlat21 = clamp(u_xlat21, 0.0f, 1.0f);
    u_xlat7 = (-u_xlat2.w) + 1.0;
    u_xlat14 = u_xlat7 * u_xlat7;
    u_xlat16_10.x = half(u_xlat7 * u_xlat14);
    u_xlat16_10.x = fma((-u_xlat16_10.x), half(0.280000001), half(1.0));
    u_xlat16_3 = (-u_xlat16_3) + half(1.0);
    u_xlat16_3 = half(u_xlat2.w + float(u_xlat16_3));
    u_xlat16_3 = clamp(u_xlat16_3, 0.0h, 1.0h);
    u_xlat16_10.xyz = u_xlat16_4.xyz * u_xlat16_10.xxx;
    u_xlat16_6.x = half((-u_xlat21) + 1.0);
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_13.xyz = half3((-u_xlat2.xyz) + float3(u_xlat16_3));
    u_xlat16_6.xyz = half3(fma(float3(u_xlat16_6.xxx), float3(u_xlat16_13.xyz), u_xlat2.xyz));
    u_xlat16_7.xyz = _CameraReflectionsTexture.sample(sampler_CameraReflectionsTexture, input.TEXCOORD1.xy).xyz;
    u_xlat16_2 = _MainTex.sample(sampler_MainTex, input.TEXCOORD1.xy);
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + u_xlat16_2.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, half3(0.0, 0.0, 0.0));
    u_xlat16_2.x = u_xlat16_4.w * u_xlat16_4.w;
    u_xlat16_9 = u_xlat16_2.x * half(3.0);
    u_xlat16_2.x = fma(u_xlat16_2.x, half(3.0), half(-0.5));
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0h, 1.0h);
    u_xlat16_16 = fma(u_xlat16_2.x, half(-2.0), half(3.0));
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_16;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_9;
    u_xlat2.x = float(u_xlat16_2.x) * FGlobals._Params.y;
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat16_2.xyz = fma(u_xlat16_10.xyz, u_xlat16_6.xyz, (-u_xlat16_7.xyz));
    u_xlat0.xyz = fma(u_xlat0.xxx, float3(u_xlat16_2.xyz), float3(u_xlat16_7.xyz));
    output.SV_Target0.xyz = fma(u_xlat0.xyz, float3(u_xlat1), float3(u_xlat16_8.xyz));
    output.SV_Target0.w = float(u_xlat16_2.w);
    return output;
}
"
}
}
}
}
}
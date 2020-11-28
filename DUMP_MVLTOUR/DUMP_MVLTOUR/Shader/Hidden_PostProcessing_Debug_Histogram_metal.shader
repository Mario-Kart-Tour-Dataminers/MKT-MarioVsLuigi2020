//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/Debug/Histogram" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 13664
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
    float2 _Params;
};

struct _HistogramBuffer_Type
{
    uint value[1];
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    const device _HistogramBuffer_Type *_HistogramBuffer [[ buffer(1) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    _HistogramBuffer = reinterpret_cast<const device _HistogramBuffer_Type *> (reinterpret_cast<device const atomic_uint *> (_HistogramBuffer) + 1);
    float2 u_xlat0;
    uint u_xlatu0;
    uint u_xlatu1;
    u_xlatu0 = _HistogramBuffer[0x0].value[(0x0 >> 2) + 0];
    u_xlatu1 = _HistogramBuffer[0x1].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x2].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x3].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x4].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x5].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x6].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x7].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x8].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x9].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x10].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x11].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x12].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x13].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x14].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x15].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x16].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x17].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x18].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x19].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x1a].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x1b].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x1c].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x1d].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x1e].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x1f].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x20].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x21].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x22].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x23].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x24].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x25].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x26].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x27].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x28].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x29].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x2a].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x2b].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x2c].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x2d].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x2e].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x2f].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x30].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x31].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x32].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x33].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x34].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x35].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x36].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x37].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x38].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x39].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x3a].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x3b].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x3c].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x3d].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x3e].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x3f].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x40].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x41].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x42].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x43].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x44].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x45].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x46].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x47].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x48].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x49].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x4a].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x4b].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x4c].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x4d].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x4e].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x4f].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x50].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x51].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x52].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x53].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x54].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x55].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x56].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x57].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x58].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x59].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x5a].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x5b].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x5c].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x5d].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x5e].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x5f].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x60].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x61].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x62].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x63].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x64].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x65].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x66].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x67].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x68].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x69].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x6a].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x6b].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x6c].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x6d].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x6e].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x6f].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x70].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x71].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x72].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x73].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x74].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x75].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x76].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x77].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x78].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x79].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x7a].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x7b].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x7c].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x7d].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x7e].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x7f].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x80].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x81].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlatu1 = _HistogramBuffer[0x82].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x83].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x84].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x85].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x86].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x87].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x88].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x89].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x8a].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x8b].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x8c].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x8d].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x8e].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x8f].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x90].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x91].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x92].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x93].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x94].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x95].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x96].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x97].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x98].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x99].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x9a].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x9b].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x9c].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x9d].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x9e].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x9f].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa0].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa1].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa2].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa3].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa4].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa5].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa6].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa7].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa8].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa9].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xaa].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xab].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xac].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xad].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xae].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xaf].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb0].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb1].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb2].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb3].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb4].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb5].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb6].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb7].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb8].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb9].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xba].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xbb].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xbc].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xbd].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xbe].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xbf].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc0].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc1].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc2].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc3].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc4].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc5].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc6].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc7].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc8].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc9].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xca].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xcb].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xcc].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xcd].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xce].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xcf].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd0].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd1].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd2].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd3].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd4].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd5].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd6].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd7].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd8].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd9].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xda].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xdb].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xdc].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xdd].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xde].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xdf].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe0].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe1].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe2].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe3].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe4].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe5].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe6].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe7].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe8].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe9].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xea].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xeb].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xec].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xed].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xee].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xef].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf0].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf1].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf2].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf3].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf4].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf5].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf6].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf7].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf8].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf9].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xfa].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xfb].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xfc].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xfd].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xfe].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xff].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlat0.x = float(u_xlatu0);
    output.TEXCOORD1 = VGlobals._Params.xyxx.y / u_xlat0.x;
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    output.TEXCOORD0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
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
    float2 _Params;
};

struct _HistogramBuffer_Type
{
    uint value[1];
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    const device _HistogramBuffer_Type *_HistogramBuffer [[ buffer(1) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    _HistogramBuffer = reinterpret_cast<const device _HistogramBuffer_Type *> (reinterpret_cast<device const atomic_uint *> (_HistogramBuffer) + 1);
    float2 u_xlat0;
    uint u_xlatu0;
    uint u_xlatu1;
    u_xlatu0 = _HistogramBuffer[0x0].value[(0x0 >> 2) + 0];
    u_xlatu1 = _HistogramBuffer[0x1].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x2].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x3].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x4].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x5].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x6].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x7].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x8].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x9].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x10].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x11].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x12].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x13].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x14].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x15].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x16].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x17].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x18].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x19].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x1a].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x1b].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x1c].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x1d].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x1e].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x1f].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x20].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x21].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x22].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x23].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x24].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x25].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x26].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x27].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x28].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x29].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x2a].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x2b].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x2c].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x2d].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x2e].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x2f].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x30].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x31].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x32].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x33].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x34].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x35].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x36].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x37].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x38].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x39].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x3a].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x3b].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x3c].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x3d].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x3e].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x3f].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x40].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x41].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x42].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x43].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x44].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x45].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x46].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x47].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x48].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x49].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x4a].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x4b].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x4c].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x4d].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x4e].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x4f].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x50].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x51].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x52].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x53].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x54].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x55].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x56].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x57].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x58].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x59].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x5a].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x5b].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x5c].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x5d].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x5e].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x5f].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x60].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x61].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x62].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x63].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x64].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x65].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x66].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x67].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x68].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x69].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x6a].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x6b].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x6c].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x6d].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x6e].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x6f].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x70].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x71].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x72].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x73].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x74].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x75].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x76].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x77].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x78].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x79].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x7a].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x7b].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x7c].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x7d].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x7e].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x7f].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x80].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x81].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlatu1 = _HistogramBuffer[0x82].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x83].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x84].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x85].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x86].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x87].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x88].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x89].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x8a].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x8b].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x8c].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x8d].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x8e].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x8f].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x90].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x91].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x92].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x93].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x94].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x95].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x96].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x97].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x98].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x99].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x9a].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x9b].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x9c].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x9d].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x9e].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x9f].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa0].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa1].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa2].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa3].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa4].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa5].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa6].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa7].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa8].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa9].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xaa].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xab].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xac].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xad].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xae].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xaf].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb0].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb1].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb2].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb3].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb4].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb5].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb6].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb7].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb8].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb9].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xba].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xbb].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xbc].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xbd].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xbe].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xbf].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc0].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc1].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc2].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc3].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc4].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc5].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc6].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc7].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc8].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc9].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xca].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xcb].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xcc].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xcd].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xce].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xcf].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd0].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd1].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd2].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd3].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd4].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd5].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd6].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd7].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd8].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd9].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xda].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xdb].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xdc].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xdd].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xde].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xdf].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe0].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe1].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe2].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe3].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe4].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe5].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe6].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe7].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe8].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe9].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xea].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xeb].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xec].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xed].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xee].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xef].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf0].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf1].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf2].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf3].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf4].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf5].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf6].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf7].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf8].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf9].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xfa].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xfb].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xfc].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xfd].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xfe].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xff].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlat0.x = float(u_xlatu0);
    output.TEXCOORD1 = VGlobals._Params.xyxx.y / u_xlat0.x;
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    output.TEXCOORD0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
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
    float2 _Params;
};

struct _HistogramBuffer_Type
{
    uint value[1];
};

struct Mtl_VertexIn
{
    float3 POSITION0 [[ attribute(0) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    const device _HistogramBuffer_Type *_HistogramBuffer [[ buffer(1) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    _HistogramBuffer = reinterpret_cast<const device _HistogramBuffer_Type *> (reinterpret_cast<device const atomic_uint *> (_HistogramBuffer) + 1);
    float2 u_xlat0;
    uint u_xlatu0;
    uint u_xlatu1;
    u_xlatu0 = _HistogramBuffer[0x0].value[(0x0 >> 2) + 0];
    u_xlatu1 = _HistogramBuffer[0x1].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x2].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x3].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x4].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x5].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x6].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x7].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x8].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x9].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x10].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x11].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x12].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x13].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x14].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x15].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x16].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x17].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x18].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x19].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x1a].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x1b].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x1c].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x1d].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x1e].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x1f].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x20].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x21].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x22].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x23].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x24].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x25].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x26].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x27].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x28].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x29].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x2a].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x2b].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x2c].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x2d].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x2e].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x2f].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x30].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x31].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x32].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x33].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x34].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x35].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x36].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x37].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x38].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x39].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x3a].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x3b].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x3c].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x3d].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x3e].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x3f].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x40].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x41].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x42].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x43].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x44].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x45].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x46].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x47].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x48].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x49].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x4a].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x4b].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x4c].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x4d].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x4e].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x4f].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x50].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x51].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x52].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x53].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x54].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x55].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x56].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x57].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x58].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x59].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x5a].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x5b].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x5c].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x5d].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x5e].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x5f].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x60].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x61].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x62].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x63].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x64].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x65].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x66].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x67].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x68].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x69].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x6a].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x6b].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x6c].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x6d].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x6e].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x6f].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x70].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x71].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x72].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x73].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x74].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x75].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x76].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x77].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x78].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x79].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x7a].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x7b].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x7c].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x7d].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x7e].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x7f].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x80].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x81].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    output.mtl_Position.xy = input.POSITION0.xy;
    output.mtl_Position.zw = float2(0.0, 1.0);
    u_xlatu1 = _HistogramBuffer[0x82].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x83].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x84].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x85].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x86].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x87].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x88].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x89].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x8a].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x8b].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x8c].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x8d].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x8e].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x8f].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x90].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x91].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x92].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x93].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x94].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x95].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x96].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x97].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x98].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x99].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x9a].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x9b].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x9c].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x9d].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x9e].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0x9f].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa0].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa1].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa2].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa3].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa4].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa5].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa6].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa7].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa8].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xa9].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xaa].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xab].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xac].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xad].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xae].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xaf].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb0].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb1].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb2].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb3].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb4].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb5].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb6].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb7].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb8].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xb9].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xba].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xbb].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xbc].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xbd].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xbe].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xbf].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc0].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc1].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc2].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc3].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc4].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc5].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc6].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc7].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc8].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xc9].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xca].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xcb].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xcc].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xcd].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xce].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xcf].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd0].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd1].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd2].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd3].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd4].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd5].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd6].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd7].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd8].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xd9].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xda].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xdb].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xdc].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xdd].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xde].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xdf].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe0].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe1].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe2].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe3].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe4].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe5].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe6].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe7].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe8].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xe9].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xea].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xeb].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xec].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xed].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xee].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xef].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf0].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf1].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf2].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf3].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf4].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf5].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf6].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf7].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf8].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xf9].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xfa].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xfb].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xfc].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xfd].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xfe].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlatu1 = _HistogramBuffer[0xff].value[(0x0 >> 2) + 0];
    u_xlatu0 = max(u_xlatu1, u_xlatu0);
    u_xlat0.x = float(u_xlatu0);
    output.TEXCOORD1 = VGlobals._Params.xyxx.y / u_xlat0.x;
    u_xlat0.xy = input.POSITION0.xy + float2(1.0, 1.0);
    output.TEXCOORD0.xy = fma(u_xlat0.xy, float2(0.5, -0.5), float2(0.0, 1.0));
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
    float2 _Params;
};

struct _HistogramBuffer_Type
{
    uint value[1];
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    const device _HistogramBuffer_Type *_HistogramBuffer [[ buffer(1) ]],
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    _HistogramBuffer = reinterpret_cast<const device _HistogramBuffer_Type *> (reinterpret_cast<device const atomic_uint *> (_HistogramBuffer) + 1);
    float u_xlat0;
    bool u_xlatb0;
    float2 u_xlat1;
    uint2 u_xlatu1;
    float u_xlat2;
    uint u_xlatu2;
    u_xlat0 = input.TEXCOORD0.x * 255.0;
    u_xlat1.x = floor(u_xlat0);
    u_xlat0 = fract(u_xlat0);
    u_xlatu1.x = uint(u_xlat1.x);
    u_xlatu1.y = u_xlatu1.x + 0x1u;
    u_xlatu1.x = _HistogramBuffer[u_xlatu1.x].value[(0x0 >> 2) + 0];
    u_xlat1.xy = float2(u_xlatu1.xy);
    u_xlat2 = min(u_xlat1.y, 255.0);
    u_xlatu2 = uint(u_xlat2);
    u_xlatu2 = _HistogramBuffer[u_xlatu2].value[(0x0 >> 2) + 0];
    u_xlat1.y = float(u_xlatu2);
    u_xlat1.xy = u_xlat1.xy * input.TEXCOORD1;
    u_xlat2 = u_xlat0 * u_xlat1.y;
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat0 = fma(u_xlat1.x, u_xlat0, u_xlat2);
    u_xlat1.x = input.TEXCOORD0.y * FGlobals._Params.xyxx.y;
    u_xlat1.x = rint(u_xlat1.x);
    u_xlatu1.x = uint(u_xlat1.x);
    u_xlat1.x = float(u_xlatu1.x);
    u_xlatb0 = u_xlat0>=u_xlat1.x;
    output.SV_Target0.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(bool3(u_xlatb0)));
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
    float2 _Params;
};

struct _HistogramBuffer_Type
{
    uint value[1];
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    const device _HistogramBuffer_Type *_HistogramBuffer [[ buffer(1) ]],
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    _HistogramBuffer = reinterpret_cast<const device _HistogramBuffer_Type *> (reinterpret_cast<device const atomic_uint *> (_HistogramBuffer) + 1);
    float u_xlat0;
    bool u_xlatb0;
    float2 u_xlat1;
    uint2 u_xlatu1;
    float u_xlat2;
    uint u_xlatu2;
    u_xlat0 = input.TEXCOORD0.x * 255.0;
    u_xlat1.x = floor(u_xlat0);
    u_xlat0 = fract(u_xlat0);
    u_xlatu1.x = uint(u_xlat1.x);
    u_xlatu1.y = u_xlatu1.x + 0x1u;
    u_xlatu1.x = _HistogramBuffer[u_xlatu1.x].value[(0x0 >> 2) + 0];
    u_xlat1.xy = float2(u_xlatu1.xy);
    u_xlat2 = min(u_xlat1.y, 255.0);
    u_xlatu2 = uint(u_xlat2);
    u_xlatu2 = _HistogramBuffer[u_xlatu2].value[(0x0 >> 2) + 0];
    u_xlat1.y = float(u_xlatu2);
    u_xlat1.xy = u_xlat1.xy * input.TEXCOORD1;
    u_xlat2 = u_xlat0 * u_xlat1.y;
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat0 = fma(u_xlat1.x, u_xlat0, u_xlat2);
    u_xlat1.x = input.TEXCOORD0.y * FGlobals._Params.xyxx.y;
    u_xlat1.x = rint(u_xlat1.x);
    u_xlatu1.x = uint(u_xlat1.x);
    u_xlat1.x = float(u_xlatu1.x);
    u_xlatb0 = u_xlat0>=u_xlat1.x;
    output.SV_Target0.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(bool3(u_xlatb0)));
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
    float2 _Params;
};

struct _HistogramBuffer_Type
{
    uint value[1];
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    const device _HistogramBuffer_Type *_HistogramBuffer [[ buffer(1) ]],
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    _HistogramBuffer = reinterpret_cast<const device _HistogramBuffer_Type *> (reinterpret_cast<device const atomic_uint *> (_HistogramBuffer) + 1);
    float u_xlat0;
    bool u_xlatb0;
    float2 u_xlat1;
    uint2 u_xlatu1;
    float u_xlat2;
    uint u_xlatu2;
    u_xlat0 = input.TEXCOORD0.x * 255.0;
    u_xlat1.x = floor(u_xlat0);
    u_xlat0 = fract(u_xlat0);
    u_xlatu1.x = uint(u_xlat1.x);
    u_xlatu1.y = u_xlatu1.x + 0x1u;
    u_xlatu1.x = _HistogramBuffer[u_xlatu1.x].value[(0x0 >> 2) + 0];
    u_xlat1.xy = float2(u_xlatu1.xy);
    u_xlat2 = min(u_xlat1.y, 255.0);
    u_xlatu2 = uint(u_xlat2);
    u_xlatu2 = _HistogramBuffer[u_xlatu2].value[(0x0 >> 2) + 0];
    u_xlat1.y = float(u_xlatu2);
    u_xlat1.xy = u_xlat1.xy * input.TEXCOORD1;
    u_xlat2 = u_xlat0 * u_xlat1.y;
    u_xlat0 = (-u_xlat0) + 1.0;
    u_xlat0 = fma(u_xlat1.x, u_xlat0, u_xlat2);
    u_xlat1.x = input.TEXCOORD0.y * FGlobals._Params.xyxx.y;
    u_xlat1.x = rint(u_xlat1.x);
    u_xlatu1.x = uint(u_xlat1.x);
    u_xlat1.x = float(u_xlatu1.x);
    u_xlatb0 = u_xlat0>=u_xlat1.x;
    output.SV_Target0.xyz = select(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0), bool3(bool3(u_xlatb0)));
    output.SV_Target0.w = 1.0;
    return output;
}
"
}
}
}
}
}
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
}
Program "fp" {
}
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 117925
Program "vp" {
}
Program "fp" {
}
}
}
}
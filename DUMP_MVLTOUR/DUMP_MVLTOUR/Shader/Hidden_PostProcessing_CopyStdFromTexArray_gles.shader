//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/CopyStdFromTexArray" {
Properties {
_MainTex ("", 2DArray) = "white" { }
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 42606
Program "vp" {
}
Program "fp" {
}
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 92485
Program "vp" {
}
Program "fp" {
}
}
}
}
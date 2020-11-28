//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/MultiScaleVO" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 46854
Program "vp" {
}
Program "fp" {
}
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 112212
Program "vp" {
}
Program "fp" {
}
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 147802
Program "vp" {
}
Program "fp" {
}
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 258340
Program "vp" {
}
Program "fp" {
}
}
}
}
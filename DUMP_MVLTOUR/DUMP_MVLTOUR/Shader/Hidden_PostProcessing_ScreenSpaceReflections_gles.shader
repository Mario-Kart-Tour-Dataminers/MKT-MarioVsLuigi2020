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
}
Program "fp" {
}
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 101441
Program "vp" {
}
Program "fp" {
}
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 154502
Program "vp" {
}
Program "fp" {
}
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 245549
Program "vp" {
}
Program "fp" {
}
}
}
}
//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/StandardCustom/MainColor_NoPS" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_Metallic ("Metallic", Range(0, 1)) = 0
_Smoothness ("Smoothness", Range(0, 1)) = 0
_Occlusion ("Occlusion", Range(0, 1)) = 1
[Header(Booster Reflection Cube Map)] [KeywordEnum(NO,YES,FIXEDCOLOR)] _ReflectionProbeType ("個別リフレクションキューブマップ使用", Float) = 0
_HeuristicReflection ("個別リフレクションキューブマップ", Cube) = "_Skybox" { }
_NormalDiff ("疑似LOD反射の揺らぎ", Range(-1, 1)) = 0
_NormalRand ("疑似LOD乱数値", Vector) = (9993.169,5715.817,4488.509,34.2347)
_FixedReflColor ("単色リフレクションカラー", Color) = (1,1,1,1)
[Space(20)] [Enum(NO,0,YES,128)] _StencilOp ("置き影が落ちなくなる", Float) = 0
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" }
  GpuProgramID 51657
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
float u_xlat24;
bool u_xlatb24;
float u_xlat26;
mediump float u_xlat16_28;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb24 = u_xlat24<9.99999975e-06;
    u_xlat24 = (u_xlatb24) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat2.z = u_xlat24 * u_xlat16_1.x;
    u_xlat3.x = u_xlat24 * u_xlat16_1.z;
    u_xlat2.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat3.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat24 = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat3.z = (-_Smoothness) + 1.0;
    u_xlatb24 = u_xlat3.z<0.00499999989;
    u_xlat26 = u_xlat3.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb24) ? 0.0 : u_xlat26;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_4.x = u_xlat10_1.w + -1.0;
    u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat24 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * vs_TEXCOORD0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat26 = u_xlat24;
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat24)) + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat24) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat3.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = (-u_xlat26) + 1.0;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_28 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_29 = (-u_xlat16_28) + _Smoothness;
    u_xlat16_29 = u_xlat16_29 + 1.0;
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_7.xyz = vec3(u_xlat16_29) + (-u_xlat16_6.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat0.xxx * u_xlat16_6.xyz;
    u_xlat16_6.xyz = _Color.xyz * vec3(u_xlat16_28) + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
float u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_14;
float u_xlat16;
float u_xlat24;
float u_xlat27;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat9.xyz = u_xlat8.xyz * vec3(u_xlat1);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat9.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat9.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat27 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat27;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_29 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_29 = (-u_xlat16_29) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_29);
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat9.x = dot(u_xlat3.xyz, u_xlat9.xyz);
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
    u_xlat16_29 = (-u_xlat9.x) + 1.0;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_6 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_14.x = (-u_xlat16_6) + _Smoothness;
    u_xlat16_14.x = u_xlat16_14.x + 1.0;
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0, 1.0);
    u_xlat16_7.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_14.xyz = u_xlat16_14.xxx + (-u_xlat16_7.xyz);
    u_xlat16_14.xyz = vec3(u_xlat16_29) * u_xlat16_14.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_14.xyz;
    u_xlat9.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat9.x = max(u_xlat9.x, 0.00100000005);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat9.xxx;
    u_xlat9.x = dot(_WorldSpaceLightPos0.xyz, u_xlat8.xyz);
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat8.xyz);
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
    u_xlat16 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
    u_xlat8.x = u_xlat8.x * u_xlat8.x;
    u_xlat24 = max(u_xlat9.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat24;
    u_xlat24 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat8.x = u_xlat8.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyw = _Color.xyz * vec3(u_xlat16_6) + u_xlat0.xyw;
    u_xlat0.xyw = u_xlat0.xyw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * vec3(u_xlat16) + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
float u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_14;
float u_xlat16;
float u_xlat24;
float u_xlat27;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat9.xyz = u_xlat8.xyz * vec3(u_xlat1);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat9.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat9.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat27 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat27;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_29 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_29 = (-u_xlat16_29) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_29);
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat9.x = dot(u_xlat3.xyz, u_xlat9.xyz);
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
    u_xlat16_29 = (-u_xlat9.x) + 1.0;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_6 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_14.x = (-u_xlat16_6) + _Smoothness;
    u_xlat16_14.x = u_xlat16_14.x + 1.0;
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0, 1.0);
    u_xlat16_7.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_14.xyz = u_xlat16_14.xxx + (-u_xlat16_7.xyz);
    u_xlat16_14.xyz = vec3(u_xlat16_29) * u_xlat16_14.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_14.xyz;
    u_xlat9.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat9.x = max(u_xlat9.x, 0.00100000005);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat9.xxx;
    u_xlat9.x = dot(_WorldSpaceLightPos0.xyz, u_xlat8.xyz);
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat8.xyz);
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
    u_xlat16 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
    u_xlat8.x = u_xlat8.x * u_xlat8.x;
    u_xlat24 = max(u_xlat9.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat24;
    u_xlat24 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat8.x = u_xlat8.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyw = _Color.xyz * vec3(u_xlat16_6) + u_xlat0.xyw;
    u_xlat0.xyw = u_xlat0.xyw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * vec3(u_xlat16) + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat27;
mediump float u_xlat16_28;
mediump float u_xlat16_30;
float u_xlat31;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_28 = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_28 = u_xlat16_28 + u_xlat16_28;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-vec3(u_xlat16_28)) + (-u_xlat0.xyz);
    u_xlat10_2 = textureCube(_HeuristicReflection, u_xlat16_2.xyz);
    u_xlat16_28 = u_xlat10_2.w + -1.0;
    u_xlat16_28 = unity_SpecCube0_HDR.w * u_xlat16_28 + 1.0;
    u_xlat16_28 = u_xlat16_28 * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(u_xlat16_28);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Occlusion);
    u_xlat27 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * vs_TEXCOORD0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat31 = u_xlat27;
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat0.xyz = u_xlat4.xyz * (-vec3(u_xlat27)) + u_xlat0.xyz;
    u_xlat27 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_28 = (-u_xlat31) + 1.0;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_9;
    u_xlat16_28 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_30 = (-u_xlat16_28) + _Smoothness;
    u_xlat16_6.xyz = vec3(u_xlat16_28) * _Color.xyz;
    u_xlat16_28 = u_xlat16_30 + 1.0;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_7.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_28) + (-u_xlat16_7.xyz);
    u_xlat16_8.xyz = vec3(u_xlat16_9) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz + u_xlat16_3.xyz;
    u_xlat0.z = (-_Smoothness) + 1.0;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * u_xlat16_5.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
mediump float u_xlat16_15;
float u_xlat18;
mediump float u_xlat16_19;
mediump float u_xlat16_20;
float u_xlat21;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_19 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = vec3(u_xlat16_19) * _Color.xyz;
    u_xlat16_19 = (-u_xlat16_19) + _Smoothness;
    u_xlat16_19 = u_xlat16_19 + 1.0;
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = max(u_xlat18, 0.00100000005);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat18 = dot(_WorldSpaceLightPos0.xyz, u_xlat3.xyz);
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlat18 = max(u_xlat18, 0.319999993);
    u_xlat16_21 = (-_Smoothness) + 1.0;
    u_xlat16_4 = u_xlat16_21 * u_xlat16_21 + 1.5;
    u_xlat18 = u_xlat18 * u_xlat16_4;
    u_xlat4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD0.xyz;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat16_9 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_20 = u_xlat16_21 * u_xlat16_9;
    u_xlat16_20 = (-u_xlat16_20) * 0.280000001 + 1.0;
    u_xlat16_15 = u_xlat16_9 * u_xlat16_9 + -1.0;
    u_xlat3.x = u_xlat3.x * u_xlat16_15 + 1.00001001;
    u_xlat18 = u_xlat18 * u_xlat3.x;
    u_xlat18 = u_xlat16_9 / u_xlat18;
    u_xlat18 = u_xlat18 + -9.99999975e-05;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = min(u_xlat18, 100.0);
    u_xlat16_5.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _LightColor0.xyz;
    u_xlat18 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat16_2.x = (-u_xlat21) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat18) + u_xlat16_1.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat10_0 = textureCube(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_20);
    u_xlat16_8.xyz = vec3(u_xlat16_19) + (-u_xlat16_5.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_8.xyz + u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz + u_xlat3.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
mediump float u_xlat16_15;
float u_xlat18;
mediump float u_xlat16_19;
mediump float u_xlat16_20;
float u_xlat21;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_19 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = vec3(u_xlat16_19) * _Color.xyz;
    u_xlat16_19 = (-u_xlat16_19) + _Smoothness;
    u_xlat16_19 = u_xlat16_19 + 1.0;
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = max(u_xlat18, 0.00100000005);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat18 = dot(_WorldSpaceLightPos0.xyz, u_xlat3.xyz);
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlat18 = max(u_xlat18, 0.319999993);
    u_xlat16_21 = (-_Smoothness) + 1.0;
    u_xlat16_4 = u_xlat16_21 * u_xlat16_21 + 1.5;
    u_xlat18 = u_xlat18 * u_xlat16_4;
    u_xlat4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD0.xyz;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat16_9 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_20 = u_xlat16_21 * u_xlat16_9;
    u_xlat16_20 = (-u_xlat16_20) * 0.280000001 + 1.0;
    u_xlat16_15 = u_xlat16_9 * u_xlat16_9 + -1.0;
    u_xlat3.x = u_xlat3.x * u_xlat16_15 + 1.00001001;
    u_xlat18 = u_xlat18 * u_xlat3.x;
    u_xlat18 = u_xlat16_9 / u_xlat18;
    u_xlat18 = u_xlat18 + -9.99999975e-05;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = min(u_xlat18, 100.0);
    u_xlat16_5.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _LightColor0.xyz;
    u_xlat18 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat16_2.x = (-u_xlat21) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat18) + u_xlat16_1.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat10_0 = textureCube(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_20);
    u_xlat16_8.xyz = vec3(u_xlat16_19) + (-u_xlat16_5.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_8.xyz + u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz + u_xlat3.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_31;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_31 = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_31 = u_xlat16_31 + u_xlat16_31;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-vec3(u_xlat16_31)) + (-u_xlat0.xyz);
    u_xlat30 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb30 = u_xlat30<9.99999975e-06;
    u_xlat30 = (u_xlatb30) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat30 * u_xlat16_2.x;
    u_xlat4.x = u_xlat30 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat30 = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat30) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat4.z = (-_Smoothness) + 1.0;
    u_xlatb30 = u_xlat4.z<0.00499999989;
    u_xlat33 = u_xlat4.z * 8.29800034;
    u_xlat16_31 = (u_xlatb30) ? 0.0 : u_xlat33;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_31);
    u_xlat16_31 = u_xlat10_2.w + -1.0;
    u_xlat16_31 = unity_SpecCube0_HDR.w * u_xlat16_31 + 1.0;
    u_xlat16_31 = u_xlat16_31 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vec3(u_xlat16_31);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat30 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * vs_TEXCOORD0.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat33 = u_xlat30;
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat30)) + u_xlat0.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat30) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_31 = (-u_xlat33) + 1.0;
    u_xlat16_10 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_10 = u_xlat16_31 * u_xlat16_10;
    u_xlat16_10 = u_xlat16_31 * u_xlat16_10;
    u_xlat16_31 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_35 = (-u_xlat16_31) + _Smoothness;
    u_xlat16_7.xyz = vec3(u_xlat16_31) * _Color.xyz;
    u_xlat16_31 = u_xlat16_35 + 1.0;
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat16_8.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_9.xyz = vec3(u_xlat16_31) + (-u_xlat16_8.xyz);
    u_xlat16_9.xyz = vec3(u_xlat16_10) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_7.xyz + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_8.xyz * u_xlat16_6.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * vec3(u_xlat1);
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_35) * _Color.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat2.xyz = vs_TEXCOORD0.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * vec3(u_xlat1);
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_35) * _Color.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat2.xyz = vs_TEXCOORD0.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
float u_xlat24;
mediump float u_xlat16_25;
mediump float u_xlat16_27;
float u_xlat28;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_25 = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_25 = u_xlat16_25 + u_xlat16_25;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-vec3(u_xlat16_25)) + (-u_xlat0.xyz);
    u_xlat10_2 = textureCube(_HeuristicReflection, u_xlat16_2.xyz);
    u_xlat16_25 = u_xlat10_2.w + -1.0;
    u_xlat16_25 = unity_SpecCube0_HDR.w * u_xlat16_25 + 1.0;
    u_xlat16_25 = u_xlat16_25 * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(u_xlat16_25);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Occlusion);
    u_xlat24 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * vs_TEXCOORD0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat28 = u_xlat24;
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat0.xyz = u_xlat4.xyz * (-vec3(u_xlat24)) + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_25 = (-u_xlat28) + 1.0;
    u_xlat16_8 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_8 = u_xlat16_25 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_25 * u_xlat16_8;
    u_xlat16_25 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_27 = (-u_xlat16_25) + _Smoothness;
    u_xlat16_5.xyz = vec3(u_xlat16_25) * _Color.xyz;
    u_xlat16_25 = u_xlat16_27 + 1.0;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_7.xyz = vec3(u_xlat16_25) + (-u_xlat16_6.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_7.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlat10_2 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_25 = dot(u_xlat10_2, unity_OcclusionMaskSelector);
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_3.xyz = vec3(u_xlat16_25) * _LightColor0.xyz;
    u_xlat16_3.xyz = vec3(u_xlat24) * u_xlat16_3.xyz;
    u_xlat0.z = (-_Smoothness) + 1.0;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_5.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_3.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
mediump float u_xlat16_18;
float u_xlat21;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
float u_xlat25;
mediump float u_xlat16_25;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_22 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = vec3(u_xlat16_22) * _Color.xyz;
    u_xlat16_22 = (-u_xlat16_22) + _Smoothness;
    u_xlat16_22 = u_xlat16_22 + 1.0;
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_23 = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * _LightColor0.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = max(u_xlat21, 0.00100000005);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat21 = max(u_xlat21, 0.319999993);
    u_xlat16_25 = (-_Smoothness) + 1.0;
    u_xlat16_5 = u_xlat16_25 * u_xlat16_25 + 1.5;
    u_xlat21 = u_xlat21 * u_xlat16_5;
    u_xlat5.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD0.xyz;
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat16_11 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_23 = u_xlat16_25 * u_xlat16_11;
    u_xlat16_23 = (-u_xlat16_23) * 0.280000001 + 1.0;
    u_xlat16_18 = u_xlat16_11 * u_xlat16_11 + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat16_18 + 1.00001001;
    u_xlat21 = u_xlat21 * u_xlat4.x;
    u_xlat21 = u_xlat16_11 / u_xlat21;
    u_xlat21 = u_xlat21 + -9.99999975e-05;
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat21 = min(u_xlat21, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat16_3.xyz * u_xlat4.xyz;
    u_xlat21 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat25 = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
    u_xlat16_2.x = (-u_xlat25) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat16_1.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat10_0 = textureCube(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_23);
    u_xlat16_9.xyz = vec3(u_xlat16_22) + (-u_xlat16_6.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_9.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
mediump float u_xlat16_18;
float u_xlat21;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
float u_xlat25;
mediump float u_xlat16_25;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_22 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = vec3(u_xlat16_22) * _Color.xyz;
    u_xlat16_22 = (-u_xlat16_22) + _Smoothness;
    u_xlat16_22 = u_xlat16_22 + 1.0;
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_23 = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * _LightColor0.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = max(u_xlat21, 0.00100000005);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat21 = max(u_xlat21, 0.319999993);
    u_xlat16_25 = (-_Smoothness) + 1.0;
    u_xlat16_5 = u_xlat16_25 * u_xlat16_25 + 1.5;
    u_xlat21 = u_xlat21 * u_xlat16_5;
    u_xlat5.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD0.xyz;
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat16_11 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_23 = u_xlat16_25 * u_xlat16_11;
    u_xlat16_23 = (-u_xlat16_23) * 0.280000001 + 1.0;
    u_xlat16_18 = u_xlat16_11 * u_xlat16_11 + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat16_18 + 1.00001001;
    u_xlat21 = u_xlat21 * u_xlat4.x;
    u_xlat21 = u_xlat16_11 / u_xlat21;
    u_xlat21 = u_xlat21 + -9.99999975e-05;
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat21 = min(u_xlat21, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat16_3.xyz * u_xlat4.xyz;
    u_xlat21 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat25 = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
    u_xlat16_2.x = (-u_xlat25) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat16_1.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat10_0 = textureCube(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_23);
    u_xlat16_9.xyz = vec3(u_xlat16_22) + (-u_xlat16_6.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_9.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_28 = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_28 = u_xlat16_28 + u_xlat16_28;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-vec3(u_xlat16_28)) + (-u_xlat0.xyz);
    u_xlat27 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb27 = u_xlat27<9.99999975e-06;
    u_xlat27 = (u_xlatb27) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat27 * u_xlat16_2.x;
    u_xlat4.x = u_xlat27 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat27 = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat16_2.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat4.z = (-_Smoothness) + 1.0;
    u_xlatb27 = u_xlat4.z<0.00499999989;
    u_xlat30 = u_xlat4.z * 8.29800034;
    u_xlat16_28 = (u_xlatb27) ? 0.0 : u_xlat30;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_28);
    u_xlat16_28 = u_xlat10_2.w + -1.0;
    u_xlat16_28 = unity_SpecCube0_HDR.w * u_xlat16_28 + 1.0;
    u_xlat16_28 = u_xlat16_28 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vec3(u_xlat16_28);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat27 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * vs_TEXCOORD0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat30 = u_xlat27;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat27)) + u_xlat0.xyz;
    u_xlat27 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = (-u_xlat30) + 1.0;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_9;
    u_xlat16_28 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_32 = (-u_xlat16_28) + _Smoothness;
    u_xlat16_6.xyz = vec3(u_xlat16_28) * _Color.xyz;
    u_xlat16_28 = u_xlat16_32 + 1.0;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_7.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_28) + (-u_xlat16_7.xyz);
    u_xlat16_8.xyz = vec3(u_xlat16_9) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat10_2 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_28 = dot(u_xlat10_2, unity_OcclusionMaskSelector);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat16_28) * _LightColor0.xyz;
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_5.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * vec3(u_xlat1);
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_35) * _Color.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat10_2 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_35 = dot(u_xlat10_2, unity_OcclusionMaskSelector);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
    u_xlat16_9.xyz = vec3(u_xlat16_35) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat2.xyz = vs_TEXCOORD0.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * vec3(u_xlat1);
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_35) * _Color.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat10_2 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_35 = dot(u_xlat10_2, unity_OcclusionMaskSelector);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
    u_xlat16_9.xyz = vec3(u_xlat16_35) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat2.xyz = vs_TEXCOORD0.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
float u_xlat24;
mediump float u_xlat16_26;
float u_xlat27;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat10_1 = textureCube(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_2.x = u_xlat10_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Occlusion);
    u_xlat24 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * vs_TEXCOORD0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat27 = u_xlat24;
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat24)) + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat24) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_26 = (-u_xlat27) + 1.0;
    u_xlat16_8 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_8 = u_xlat16_26 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_26 * u_xlat16_8;
    u_xlat16_26 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_28 = (-u_xlat16_26) + _Smoothness;
    u_xlat16_5.xyz = vec3(u_xlat16_26) * _Color.xyz;
    u_xlat16_26 = u_xlat16_28 + 1.0;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_7.xyz = vec3(u_xlat16_26) + (-u_xlat16_6.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Occlusion);
    u_xlat16_2.xyz = u_xlat16_7.xyz * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat0.z = (-_Smoothness) + 1.0;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_5.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_4.xyz + u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_9;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_17;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_25;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat24 = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat24 = max(u_xlat24, 0.319999993);
    u_xlat16_25 = (-_Smoothness) + 1.0;
    u_xlat16_2 = u_xlat16_25 * u_xlat16_25 + 1.5;
    u_xlat24 = u_xlat24 * u_xlat16_2;
    u_xlat2.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD0.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_9 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_3 = u_xlat16_25 * u_xlat16_9;
    u_xlat16_3 = (-u_xlat16_3) * 0.280000001 + 1.0;
    u_xlat16_17 = u_xlat16_9 * u_xlat16_9 + -1.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_17 + 1.00001001;
    u_xlat24 = u_xlat24 * u_xlat1.x;
    u_xlat24 = u_xlat16_9 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_11.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_11.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_11.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_4.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_12.xyz = u_xlat16_4.xxx * _Color.xyz;
    u_xlat16_4.x = (-u_xlat16_4.x) + _Smoothness;
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_5.xyz = (-u_xlat16_11.xyz) + u_xlat16_4.xxx;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_11.xyz + u_xlat16_12.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = u_xlat16_12.xyz * u_xlat16_7.xyz;
    u_xlat24 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
    u_xlat16_28 = (-u_xlat25) + 1.0;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_11.xyz = vec3(u_xlat16_28) * u_xlat16_5.xyz + u_xlat16_11.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + u_xlat16_4.xyz;
    u_xlat16_4.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_4.x;
    u_xlat16_4.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_4.xxx) + (-u_xlat0.xyz);
    u_xlat10_0 = textureCube(_HeuristicReflection, u_xlat16_4.xyz);
    u_xlat16_4.x = u_xlat10_0.w + -1.0;
    u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = vec3(u_xlat16_3) * u_xlat16_4.xyz;
    u_xlat0.xyz = u_xlat16_4.xyz * u_xlat16_11.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_9;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_17;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_25;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat24 = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat24 = max(u_xlat24, 0.319999993);
    u_xlat16_25 = (-_Smoothness) + 1.0;
    u_xlat16_2 = u_xlat16_25 * u_xlat16_25 + 1.5;
    u_xlat24 = u_xlat24 * u_xlat16_2;
    u_xlat2.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD0.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_9 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_3 = u_xlat16_25 * u_xlat16_9;
    u_xlat16_3 = (-u_xlat16_3) * 0.280000001 + 1.0;
    u_xlat16_17 = u_xlat16_9 * u_xlat16_9 + -1.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_17 + 1.00001001;
    u_xlat24 = u_xlat24 * u_xlat1.x;
    u_xlat24 = u_xlat16_9 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_11.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_11.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_11.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_4.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_12.xyz = u_xlat16_4.xxx * _Color.xyz;
    u_xlat16_4.x = (-u_xlat16_4.x) + _Smoothness;
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_5.xyz = (-u_xlat16_11.xyz) + u_xlat16_4.xxx;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_11.xyz + u_xlat16_12.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = u_xlat16_12.xyz * u_xlat16_7.xyz;
    u_xlat24 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
    u_xlat16_28 = (-u_xlat25) + 1.0;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_11.xyz = vec3(u_xlat16_28) * u_xlat16_5.xyz + u_xlat16_11.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + u_xlat16_4.xyz;
    u_xlat16_4.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_4.x;
    u_xlat16_4.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_4.xxx) + (-u_xlat0.xyz);
    u_xlat10_0 = textureCube(_HeuristicReflection, u_xlat16_4.xyz);
    u_xlat16_4.x = u_xlat10_0.w + -1.0;
    u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = vec3(u_xlat16_3) * u_xlat16_4.xyz;
    u_xlat0.xyz = u_xlat16_4.xyz * u_xlat16_11.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat27;
bool u_xlatb27;
float u_xlat29;
mediump float u_xlat16_31;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat27 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb27 = u_xlat27<9.99999975e-06;
    u_xlat27 = (u_xlatb27) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat2.z = u_xlat27 * u_xlat16_1.x;
    u_xlat3.x = u_xlat27 * u_xlat16_1.z;
    u_xlat2.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat3.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat27 = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat27) + u_xlat16_1.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat3.z = (-_Smoothness) + 1.0;
    u_xlatb27 = u_xlat3.z<0.00499999989;
    u_xlat29 = u_xlat3.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb27) ? 0.0 : u_xlat29;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_4.x = u_xlat10_1.w + -1.0;
    u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat27 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * vs_TEXCOORD0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat29 = u_xlat27;
    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat27)) + u_xlat0.xyz;
    u_xlat27 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat3.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_31 = (-u_xlat29) + 1.0;
    u_xlat16_9 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_9 = u_xlat16_31 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_31 * u_xlat16_9;
    u_xlat16_31 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_32 = (-u_xlat16_31) + _Smoothness;
    u_xlat16_6.xyz = vec3(u_xlat16_31) * _Color.xyz;
    u_xlat16_31 = u_xlat16_32 + 1.0;
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat16_7.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_31) + (-u_xlat16_7.xyz);
    u_xlat16_8.xyz = vec3(u_xlat16_9) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = u_xlat16_8.xyz * u_xlat16_6.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * vec3(u_xlat1);
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_35) * _Color.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_4.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * vec3(u_xlat1);
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_35) * _Color.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_4.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_12;
mediump float u_xlat16_27;
mediump float u_xlat16_29;
float u_xlat30;
float u_xlat31;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0.x = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat16_27 = dot((-u_xlat3.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_27 = u_xlat16_27 + u_xlat16_27;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-vec3(u_xlat16_27)) + (-u_xlat3.xyz);
    u_xlat10_1 = textureCube(_HeuristicReflection, u_xlat16_2.xyz);
    u_xlat16_27 = u_xlat10_1.w + -1.0;
    u_xlat16_27 = unity_SpecCube0_HDR.w * u_xlat16_27 + 1.0;
    u_xlat16_27 = u_xlat16_27 * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(u_xlat16_27);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Occlusion);
    u_xlat30 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat4.xyz = vec3(u_xlat30) * vs_TEXCOORD0.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat31 = u_xlat30;
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat3.xyz = u_xlat4.xyz * (-vec3(u_xlat30)) + u_xlat3.xyz;
    u_xlat30 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat30) * _LightColor0.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat16_27 = (-u_xlat31) + 1.0;
    u_xlat16_12 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_12 = u_xlat16_27 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_27 * u_xlat16_12;
    u_xlat16_27 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_29 = (-u_xlat16_27) + _Smoothness;
    u_xlat16_6.xyz = vec3(u_xlat16_27) * _Color.xyz;
    u_xlat16_27 = u_xlat16_29 + 1.0;
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
    u_xlat16_7.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_27) + (-u_xlat16_7.xyz);
    u_xlat16_8.xyz = vec3(u_xlat16_12) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat3.z = (-_Smoothness) + 1.0;
    u_xlat3.x = texture2D(unity_NHxRoughness, u_xlat3.xz).x;
    u_xlat3.x = u_xlat3.x * 16.0;
    u_xlat16_2.xyz = u_xlat3.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
mediump float u_xlat16_18;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_25;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0.x = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_21 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = vec3(u_xlat16_21) * _Color.xyz;
    u_xlat16_21 = (-u_xlat16_21) + _Smoothness;
    u_xlat16_21 = u_xlat16_21 + 1.0;
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
    u_xlat24 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat24 = max(u_xlat24, 0.319999993);
    u_xlat16_25 = (-_Smoothness) + 1.0;
    u_xlat16_5 = u_xlat16_25 * u_xlat16_25 + 1.5;
    u_xlat24 = u_xlat24 * u_xlat16_5;
    u_xlat5.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD0.xyz;
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat16_11 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_23 = u_xlat16_25 * u_xlat16_11;
    u_xlat16_23 = (-u_xlat16_23) * 0.280000001 + 1.0;
    u_xlat16_18 = u_xlat16_11 * u_xlat16_11 + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat16_18 + 1.00001001;
    u_xlat24 = u_xlat24 * u_xlat4.x;
    u_xlat24 = u_xlat16_11 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _LightColor0.xyz;
    u_xlat24 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat25 = dot(u_xlat5.xyz, u_xlat3.xyz);
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
    u_xlat16_2.x = (-u_xlat25) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat24) + u_xlat16_0.xyz;
    u_xlat16_0.x = dot((-u_xlat3.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_0.xxx) + (-u_xlat3.xyz);
    u_xlat10_1 = textureCube(_HeuristicReflection, u_xlat16_0.xyz);
    u_xlat16_0.x = u_xlat10_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_23);
    u_xlat16_9.xyz = vec3(u_xlat16_21) + (-u_xlat16_6.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_9.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
mediump float u_xlat16_18;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_25;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0.x = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_21 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = vec3(u_xlat16_21) * _Color.xyz;
    u_xlat16_21 = (-u_xlat16_21) + _Smoothness;
    u_xlat16_21 = u_xlat16_21 + 1.0;
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
    u_xlat24 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat24 = max(u_xlat24, 0.319999993);
    u_xlat16_25 = (-_Smoothness) + 1.0;
    u_xlat16_5 = u_xlat16_25 * u_xlat16_25 + 1.5;
    u_xlat24 = u_xlat24 * u_xlat16_5;
    u_xlat5.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD0.xyz;
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat16_11 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_23 = u_xlat16_25 * u_xlat16_11;
    u_xlat16_23 = (-u_xlat16_23) * 0.280000001 + 1.0;
    u_xlat16_18 = u_xlat16_11 * u_xlat16_11 + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat16_18 + 1.00001001;
    u_xlat24 = u_xlat24 * u_xlat4.x;
    u_xlat24 = u_xlat16_11 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _LightColor0.xyz;
    u_xlat24 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat25 = dot(u_xlat5.xyz, u_xlat3.xyz);
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
    u_xlat16_2.x = (-u_xlat25) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat24) + u_xlat16_0.xyz;
    u_xlat16_0.x = dot((-u_xlat3.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_0.xxx) + (-u_xlat3.xyz);
    u_xlat10_1 = textureCube(_HeuristicReflection, u_xlat16_0.xyz);
    u_xlat16_0.x = u_xlat10_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_23);
    u_xlat16_9.xyz = vec3(u_xlat16_21) + (-u_xlat16_6.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_9.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_13;
mediump float u_xlat16_30;
mediump float u_xlat16_32;
float u_xlat33;
bool u_xlatb33;
float u_xlat34;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0.x = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat3.xyz = vec3(u_xlat33) * u_xlat3.xyz;
    u_xlat16_30 = dot((-u_xlat3.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_30 = u_xlat16_30 + u_xlat16_30;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-vec3(u_xlat16_30)) + (-u_xlat3.xyz);
    u_xlat33 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb33 = u_xlat33<9.99999975e-06;
    u_xlat33 = (u_xlatb33) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat16_2.x * u_xlat33;
    u_xlat5.x = u_xlat16_2.z * u_xlat33;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat5.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat33 = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * _NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33) + u_xlat16_2.xyz;
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz;
    u_xlat5.z = (-_Smoothness) + 1.0;
    u_xlatb33 = u_xlat5.z<0.00499999989;
    u_xlat34 = u_xlat5.z * 8.29800034;
    u_xlat16_30 = (u_xlatb33) ? 0.0 : u_xlat34;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat4.xyz, u_xlat16_30);
    u_xlat16_30 = u_xlat10_1.w + -1.0;
    u_xlat16_30 = unity_SpecCube0_HDR.w * u_xlat16_30 + 1.0;
    u_xlat16_30 = u_xlat16_30 * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(u_xlat16_30);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Occlusion);
    u_xlat33 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * vs_TEXCOORD0.xyz;
    u_xlat33 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat34 = u_xlat33;
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat3.xyz = u_xlat4.xyz * (-vec3(u_xlat33)) + u_xlat3.xyz;
    u_xlat33 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat33) * _LightColor0.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat5.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = texture2D(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat3.x = u_xlat3.x * 16.0;
    u_xlat16_30 = (-u_xlat34) + 1.0;
    u_xlat16_13 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_13 = u_xlat16_30 * u_xlat16_13;
    u_xlat16_13 = u_xlat16_30 * u_xlat16_13;
    u_xlat16_30 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_32 = (-u_xlat16_30) + _Smoothness;
    u_xlat16_7.xyz = vec3(u_xlat16_30) * _Color.xyz;
    u_xlat16_30 = u_xlat16_32 + 1.0;
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
    u_xlat16_8.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_9.xyz = vec3(u_xlat16_30) + (-u_xlat16_8.xyz);
    u_xlat16_9.xyz = vec3(u_xlat16_13) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat3.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_9.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_8.xyz * u_xlat16_6.xyz + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat24;
float u_xlat36;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat13.xyz = u_xlat12.xyz * vec3(u_xlat1);
    u_xlat12.xyz = u_xlat12.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat13.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat13.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat39 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat39;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_41 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat12.xyz = u_xlat12.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat12.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
    u_xlat12.x = u_xlat12.x * u_xlat12.x;
    u_xlat24 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat12.x = u_xlat12.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_41) * _Color.xyz;
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_41);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_41 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_41 = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_41);
    u_xlat16_2 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_41) + u_xlat16_9.xyz;
    u_xlat2.xyz = vs_TEXCOORD0.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_11.xyz + u_xlat16_4.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat13.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat16_41 = (-u_xlat1) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = vec3(u_xlat16_41) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat24;
float u_xlat36;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat13.xyz = u_xlat12.xyz * vec3(u_xlat1);
    u_xlat12.xyz = u_xlat12.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat13.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat13.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat39 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat39;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_41 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat12.xyz = u_xlat12.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat12.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
    u_xlat12.x = u_xlat12.x * u_xlat12.x;
    u_xlat24 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat12.x = u_xlat12.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_41) * _Color.xyz;
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_41);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_41 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_41 = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_41);
    u_xlat16_2 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_41) + u_xlat16_9.xyz;
    u_xlat2.xyz = vs_TEXCOORD0.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_11.xyz + u_xlat16_4.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat13.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat16_41 = (-u_xlat1) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = vec3(u_xlat16_41) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_11;
float u_xlat21;
mediump float u_xlat16_23;
float u_xlat24;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat10_1 = textureCube(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_2.x = u_xlat10_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Occlusion);
    u_xlat21 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * vs_TEXCOORD0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat24 = u_xlat21;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat21)) + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_23 = (-u_xlat24) + 1.0;
    u_xlat16_7 = u_xlat16_23 * u_xlat16_23;
    u_xlat16_7 = u_xlat16_23 * u_xlat16_7;
    u_xlat16_7 = u_xlat16_23 * u_xlat16_7;
    u_xlat16_23 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_4.x = (-u_xlat16_23) + _Smoothness;
    u_xlat16_11.xyz = vec3(u_xlat16_23) * _Color.xyz;
    u_xlat16_23 = u_xlat16_4.x + 1.0;
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
    u_xlat16_5.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_6.xyz = vec3(u_xlat16_23) + (-u_xlat16_5.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_7) * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(_Occlusion);
    u_xlat16_2.xyz = u_xlat16_6.xyz * u_xlat16_11.xyz + u_xlat16_2.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_23 = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat16_23) * _LightColor0.xyz;
    u_xlat16_6.xyz = vec3(u_xlat21) * u_xlat16_6.xyz;
    u_xlat0.z = (-_Smoothness) + 1.0;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_11.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz + u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_10;
mediump float u_xlat16_18;
float u_xlat24;
mediump float u_xlat16_25;
float u_xlat26;
mediump float u_xlat16_26;
mediump float u_xlat16_28;
void main()
{
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_1.x = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat24 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat24 = max(u_xlat24, 0.319999993);
    u_xlat16_26 = (-_Smoothness) + 1.0;
    u_xlat16_3 = u_xlat16_26 * u_xlat16_26 + 1.5;
    u_xlat24 = u_xlat24 * u_xlat16_3;
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_25 = u_xlat16_26 * u_xlat16_10;
    u_xlat16_25 = (-u_xlat16_25) * 0.280000001 + 1.0;
    u_xlat16_18 = u_xlat16_10 * u_xlat16_10 + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat16_18 + 1.00001001;
    u_xlat24 = u_xlat24 * u_xlat2.x;
    u_xlat24 = u_xlat16_10 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_4.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_28 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.xyz = vec3(u_xlat16_28) * _Color.xyz;
    u_xlat16_28 = (-u_xlat16_28) + _Smoothness;
    u_xlat16_28 = u_xlat16_28 + 1.0;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_28);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat16_4.xyz + u_xlat16_5.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    u_xlat16_7.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_7.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat16_28 = (-u_xlat26) + 1.0;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_4.xyz = vec3(u_xlat16_28) * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat10_0 = textureCube(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_10;
mediump float u_xlat16_18;
float u_xlat24;
mediump float u_xlat16_25;
float u_xlat26;
mediump float u_xlat16_26;
mediump float u_xlat16_28;
void main()
{
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_1.x = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat24 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat24 = max(u_xlat24, 0.319999993);
    u_xlat16_26 = (-_Smoothness) + 1.0;
    u_xlat16_3 = u_xlat16_26 * u_xlat16_26 + 1.5;
    u_xlat24 = u_xlat24 * u_xlat16_3;
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_25 = u_xlat16_26 * u_xlat16_10;
    u_xlat16_25 = (-u_xlat16_25) * 0.280000001 + 1.0;
    u_xlat16_18 = u_xlat16_10 * u_xlat16_10 + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat16_18 + 1.00001001;
    u_xlat24 = u_xlat24 * u_xlat2.x;
    u_xlat24 = u_xlat16_10 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_4.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_28 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.xyz = vec3(u_xlat16_28) * _Color.xyz;
    u_xlat16_28 = (-u_xlat16_28) + _Smoothness;
    u_xlat16_28 = u_xlat16_28 + 1.0;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_28);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat16_4.xyz + u_xlat16_5.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    u_xlat16_7.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_7.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat16_28 = (-u_xlat26) + 1.0;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_4.xyz = vec3(u_xlat16_28) * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat10_0 = textureCube(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_13;
float u_xlat24;
bool u_xlatb24;
float u_xlat26;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb24 = u_xlat24<9.99999975e-06;
    u_xlat24 = (u_xlatb24) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat2.z = u_xlat24 * u_xlat16_1.x;
    u_xlat3.x = u_xlat24 * u_xlat16_1.z;
    u_xlat2.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat3.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat24 = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat3.z = (-_Smoothness) + 1.0;
    u_xlatb24 = u_xlat3.z<0.00499999989;
    u_xlat26 = u_xlat3.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb24) ? 0.0 : u_xlat26;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_4.x = u_xlat10_1.w + -1.0;
    u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat24 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * vs_TEXCOORD0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat26 = u_xlat24;
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat24)) + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat3.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = (-u_xlat26) + 1.0;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_28 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.x = (-u_xlat16_28) + _Smoothness;
    u_xlat16_13.xyz = vec3(u_xlat16_28) * _Color.xyz;
    u_xlat16_28 = u_xlat16_5.x + 1.0;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_7.xyz = vec3(u_xlat16_28) + (-u_xlat16_6.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_13.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = u_xlat16_7.xyz * u_xlat16_13.xyz + u_xlat16_4.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_28 = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat16_28) * _LightColor0.xyz;
    u_xlat16_5.xyz = vec3(u_xlat24) * u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * vec3(u_xlat1);
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_35) * _Color.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat10_2 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_35 = dot(u_xlat10_2, unity_OcclusionMaskSelector);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
    u_xlat16_9.xyz = vec3(u_xlat16_35) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat16_4.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * vec3(u_xlat1);
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_35) * _Color.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat10_2 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_35 = dot(u_xlat10_2, unity_OcclusionMaskSelector);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
    u_xlat16_9.xyz = vec3(u_xlat16_35) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat16_4.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_11;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
float u_xlat27;
float u_xlat28;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0.x = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat16_24 = dot((-u_xlat3.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_24 = u_xlat16_24 + u_xlat16_24;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-vec3(u_xlat16_24)) + (-u_xlat3.xyz);
    u_xlat10_1 = textureCube(_HeuristicReflection, u_xlat16_2.xyz);
    u_xlat16_24 = u_xlat10_1.w + -1.0;
    u_xlat16_24 = unity_SpecCube0_HDR.w * u_xlat16_24 + 1.0;
    u_xlat16_24 = u_xlat16_24 * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(u_xlat16_24);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Occlusion);
    u_xlat27 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * vs_TEXCOORD0.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat28 = u_xlat27;
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat3.xyz = u_xlat4.xyz * (-vec3(u_xlat27)) + u_xlat3.xyz;
    u_xlat27 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat3.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat16_24 = (-u_xlat28) + 1.0;
    u_xlat16_11 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_11 = u_xlat16_24 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_24 * u_xlat16_11;
    u_xlat16_24 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_26 = (-u_xlat16_24) + _Smoothness;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_24 = u_xlat16_26 + 1.0;
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_7.xyz = vec3(u_xlat16_24) + (-u_xlat16_6.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_11) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_24 = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_24) * _LightColor0.xyz;
    u_xlat16_2.xyz = vec3(u_xlat27) * u_xlat16_2.xyz;
    u_xlat3.z = (-_Smoothness) + 1.0;
    u_xlat3.x = texture2D(unity_NHxRoughness, u_xlat3.xz).x;
    u_xlat3.x = u_xlat3.x * 16.0;
    u_xlat16_5.xyz = u_xlat3.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_12;
mediump float u_xlat16_20;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_28;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0.x = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_24 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_24 = (-u_xlat16_24) + _Smoothness;
    u_xlat16_24 = u_xlat16_24 + 1.0;
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_26 = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * _LightColor0.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat27 = max(u_xlat27, 0.319999993);
    u_xlat16_28 = (-_Smoothness) + 1.0;
    u_xlat16_6 = u_xlat16_28 * u_xlat16_28 + 1.5;
    u_xlat27 = u_xlat27 * u_xlat16_6;
    u_xlat6.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * vs_TEXCOORD0.xyz;
    u_xlat4.x = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat16_12 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_26 = u_xlat16_28 * u_xlat16_12;
    u_xlat16_26 = (-u_xlat16_26) * 0.280000001 + 1.0;
    u_xlat16_20 = u_xlat16_12 * u_xlat16_12 + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat16_20 + 1.00001001;
    u_xlat27 = u_xlat27 * u_xlat4.x;
    u_xlat27 = u_xlat16_12 / u_xlat27;
    u_xlat27 = u_xlat27 + -9.99999975e-05;
    u_xlat27 = max(u_xlat27, 0.0);
    u_xlat27 = min(u_xlat27, 100.0);
    u_xlat16_7.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat16_7.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat16_5.xyz * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat28 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat16_2.x = (-u_xlat28) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat16_0.xyz;
    u_xlat16_0.x = dot((-u_xlat3.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_0.xxx) + (-u_xlat3.xyz);
    u_xlat10_1 = textureCube(_HeuristicReflection, u_xlat16_0.xyz);
    u_xlat16_0.x = u_xlat10_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_26);
    u_xlat16_10.xyz = vec3(u_xlat16_24) + (-u_xlat16_7.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_10.xyz + u_xlat16_7.xyz;
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_12;
mediump float u_xlat16_20;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_28;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0.x = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_24 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_24 = (-u_xlat16_24) + _Smoothness;
    u_xlat16_24 = u_xlat16_24 + 1.0;
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_26 = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * _LightColor0.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat27 = max(u_xlat27, 0.319999993);
    u_xlat16_28 = (-_Smoothness) + 1.0;
    u_xlat16_6 = u_xlat16_28 * u_xlat16_28 + 1.5;
    u_xlat27 = u_xlat27 * u_xlat16_6;
    u_xlat6.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * vs_TEXCOORD0.xyz;
    u_xlat4.x = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat16_12 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_26 = u_xlat16_28 * u_xlat16_12;
    u_xlat16_26 = (-u_xlat16_26) * 0.280000001 + 1.0;
    u_xlat16_20 = u_xlat16_12 * u_xlat16_12 + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat16_20 + 1.00001001;
    u_xlat27 = u_xlat27 * u_xlat4.x;
    u_xlat27 = u_xlat16_12 / u_xlat27;
    u_xlat27 = u_xlat27 + -9.99999975e-05;
    u_xlat27 = max(u_xlat27, 0.0);
    u_xlat27 = min(u_xlat27, 100.0);
    u_xlat16_7.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat16_7.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat16_5.xyz * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat28 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat16_2.x = (-u_xlat28) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat16_0.xyz;
    u_xlat16_0.x = dot((-u_xlat3.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_0.xxx) + (-u_xlat3.xyz);
    u_xlat10_1 = textureCube(_HeuristicReflection, u_xlat16_0.xyz);
    u_xlat16_0.x = u_xlat10_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_26);
    u_xlat16_10.xyz = vec3(u_xlat16_24) + (-u_xlat16_7.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_10.xyz + u_xlat16_7.xyz;
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_12;
mediump float u_xlat16_27;
mediump float u_xlat16_29;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0.x = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat16_27 = dot((-u_xlat3.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_27 = u_xlat16_27 + u_xlat16_27;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-vec3(u_xlat16_27)) + (-u_xlat3.xyz);
    u_xlat30 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb30 = u_xlat30<9.99999975e-06;
    u_xlat30 = (u_xlatb30) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat16_2.x * u_xlat30;
    u_xlat5.x = u_xlat16_2.z * u_xlat30;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat5.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat30 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat30 = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat30) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz;
    u_xlat5.z = (-_Smoothness) + 1.0;
    u_xlatb30 = u_xlat5.z<0.00499999989;
    u_xlat31 = u_xlat5.z * 8.29800034;
    u_xlat16_27 = (u_xlatb30) ? 0.0 : u_xlat31;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat4.xyz, u_xlat16_27);
    u_xlat16_27 = u_xlat10_1.w + -1.0;
    u_xlat16_27 = unity_SpecCube0_HDR.w * u_xlat16_27 + 1.0;
    u_xlat16_27 = u_xlat16_27 * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(u_xlat16_27);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Occlusion);
    u_xlat30 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat4.xyz = vec3(u_xlat30) * vs_TEXCOORD0.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat31 = u_xlat30;
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat3.xyz = u_xlat4.xyz * (-vec3(u_xlat30)) + u_xlat3.xyz;
    u_xlat30 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat3.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat5.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = texture2D(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat3.x = u_xlat3.x * 16.0;
    u_xlat16_27 = (-u_xlat31) + 1.0;
    u_xlat16_12 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_12 = u_xlat16_27 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_27 * u_xlat16_12;
    u_xlat16_27 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_29 = (-u_xlat16_27) + _Smoothness;
    u_xlat16_6.xyz = vec3(u_xlat16_27) * _Color.xyz;
    u_xlat16_27 = u_xlat16_29 + 1.0;
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
    u_xlat16_7.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_27) + (-u_xlat16_7.xyz);
    u_xlat16_8.xyz = vec3(u_xlat16_12) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat3.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_27 = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_27) * _LightColor0.xyz;
    u_xlat16_2.xyz = vec3(u_xlat30) * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_2.xyz + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat24;
float u_xlat36;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat13.xyz = u_xlat12.xyz * vec3(u_xlat1);
    u_xlat12.xyz = u_xlat12.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat13.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat13.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat39 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat39;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_41 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat12.xyz = u_xlat12.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat12.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
    u_xlat12.x = u_xlat12.x * u_xlat12.x;
    u_xlat24 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat12.x = u_xlat12.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_41) * _Color.xyz;
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_41);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat10_2 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_41 = dot(u_xlat10_2, unity_OcclusionMaskSelector);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_9.xyz = vec3(u_xlat16_41) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat16_41 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_41 = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_41);
    u_xlat16_2 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_41) + u_xlat16_9.xyz;
    u_xlat2.xyz = vs_TEXCOORD0.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_11.xyz + u_xlat16_4.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat13.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat16_41 = (-u_xlat1) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = vec3(u_xlat16_41) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat24;
float u_xlat36;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat13.xyz = u_xlat12.xyz * vec3(u_xlat1);
    u_xlat12.xyz = u_xlat12.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat13.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat13.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat39 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat39;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_41 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat12.xyz = u_xlat12.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat12.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
    u_xlat12.x = u_xlat12.x * u_xlat12.x;
    u_xlat24 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat12.x = u_xlat12.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_41) * _Color.xyz;
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_41);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat10_2 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_41 = dot(u_xlat10_2, unity_OcclusionMaskSelector);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_9.xyz = vec3(u_xlat16_41) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat16_41 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_41 = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_41);
    u_xlat16_2 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_41) + u_xlat16_9.xyz;
    u_xlat2.xyz = vs_TEXCOORD0.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_11.xyz + u_xlat16_4.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat13.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat16_41 = (-u_xlat1) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = vec3(u_xlat16_41) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_7;
float u_xlat21;
mediump float u_xlat16_23;
float u_xlat24;
mediump float u_xlat16_25;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat10_1 = textureCube(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_2.x = u_xlat10_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Occlusion);
    u_xlat21 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * vs_TEXCOORD0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat24 = u_xlat21;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat21)) + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat21) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_23 = (-u_xlat24) + 1.0;
    u_xlat16_7 = u_xlat16_23 * u_xlat16_23;
    u_xlat16_7 = u_xlat16_23 * u_xlat16_7;
    u_xlat16_7 = u_xlat16_23 * u_xlat16_7;
    u_xlat16_23 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_25 = (-u_xlat16_23) + _Smoothness;
    u_xlat16_25 = u_xlat16_25 + 1.0;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_5.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_6.xyz = vec3(u_xlat16_25) + (-u_xlat16_5.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_7) * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    u_xlat0.z = (-_Smoothness) + 1.0;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat0.xxx;
    u_xlat16_5.xyz = _Color.xyz * vec3(u_xlat16_23) + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_4.xyz + u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_12;
float u_xlat14;
float u_xlat21;
mediump float u_xlat16_21;
mediump float u_xlat16_22;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat1.xyz);
    u_xlat10_2 = textureCube(_HeuristicReflection, u_xlat16_2.xyz);
    u_xlat16_3.x = u_xlat10_2.w + -1.0;
    u_xlat16_3.x = unity_SpecCube0_HDR.w * u_xlat16_3.x + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat10_2.xyz * u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Occlusion);
    u_xlat16_21 = (-_Smoothness) + 1.0;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_24 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21 + 1.5;
    u_xlat16_24 = (-u_xlat16_24) * 0.280000001 + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_24);
    u_xlat4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_24 = (-u_xlat1.x) + 1.0;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_5 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_12.x = (-u_xlat16_5) + _Smoothness;
    u_xlat16_12.x = u_xlat16_12.x + 1.0;
    u_xlat16_12.x = clamp(u_xlat16_12.x, 0.0, 1.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_12.xyz = u_xlat16_12.xxx + (-u_xlat16_6.xyz);
    u_xlat16_12.xyz = vec3(u_xlat16_24) * u_xlat16_12.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_12.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat14 = max(u_xlat1.x, 0.319999993);
    u_xlat14 = u_xlat16_21 * u_xlat14;
    u_xlat16_21 = u_xlat16_22 * u_xlat16_22 + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_21 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat14;
    u_xlat0.x = u_xlat16_22 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xzw = u_xlat16_6.xyz * u_xlat0.xxx;
    u_xlat0.xzw = _Color.xyz * vec3(u_xlat16_5) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xzw * vec3(u_xlat7) + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_12;
float u_xlat14;
float u_xlat21;
mediump float u_xlat16_21;
mediump float u_xlat16_22;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat1.xyz);
    u_xlat10_2 = textureCube(_HeuristicReflection, u_xlat16_2.xyz);
    u_xlat16_3.x = u_xlat10_2.w + -1.0;
    u_xlat16_3.x = unity_SpecCube0_HDR.w * u_xlat16_3.x + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat10_2.xyz * u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Occlusion);
    u_xlat16_21 = (-_Smoothness) + 1.0;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_24 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21 + 1.5;
    u_xlat16_24 = (-u_xlat16_24) * 0.280000001 + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_24);
    u_xlat4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_24 = (-u_xlat1.x) + 1.0;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_5 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_12.x = (-u_xlat16_5) + _Smoothness;
    u_xlat16_12.x = u_xlat16_12.x + 1.0;
    u_xlat16_12.x = clamp(u_xlat16_12.x, 0.0, 1.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_12.xyz = u_xlat16_12.xxx + (-u_xlat16_6.xyz);
    u_xlat16_12.xyz = vec3(u_xlat16_24) * u_xlat16_12.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_12.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat14 = max(u_xlat1.x, 0.319999993);
    u_xlat14 = u_xlat16_21 * u_xlat14;
    u_xlat16_21 = u_xlat16_22 * u_xlat16_22 + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_21 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat14;
    u_xlat0.x = u_xlat16_22 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xzw = u_xlat16_6.xyz * u_xlat0.xxx;
    u_xlat0.xzw = _Color.xyz * vec3(u_xlat16_5) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xzw * vec3(u_xlat7) + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
float u_xlat24;
bool u_xlatb24;
float u_xlat26;
mediump float u_xlat16_28;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb24 = u_xlat24<9.99999975e-06;
    u_xlat24 = (u_xlatb24) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat2.z = u_xlat24 * u_xlat16_1.x;
    u_xlat3.x = u_xlat24 * u_xlat16_1.z;
    u_xlat2.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat3.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat24 = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat3.z = (-_Smoothness) + 1.0;
    u_xlatb24 = u_xlat3.z<0.00499999989;
    u_xlat26 = u_xlat3.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb24) ? 0.0 : u_xlat26;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_4.x = u_xlat10_1.w + -1.0;
    u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat24 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * vs_TEXCOORD0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat26 = u_xlat24;
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat24)) + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat24) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat3.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = (-u_xlat26) + 1.0;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_28 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_29 = (-u_xlat16_28) + _Smoothness;
    u_xlat16_29 = u_xlat16_29 + 1.0;
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_7.xyz = vec3(u_xlat16_29) + (-u_xlat16_6.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat0.xxx * u_xlat16_6.xyz;
    u_xlat16_6.xyz = _Color.xyz * vec3(u_xlat16_28) + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD3;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
float u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_14;
float u_xlat16;
float u_xlat24;
float u_xlat27;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat9.xyz = u_xlat8.xyz * vec3(u_xlat1);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat9.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat9.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat27 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat27;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_29 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_29 = (-u_xlat16_29) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_29);
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat9.x = dot(u_xlat3.xyz, u_xlat9.xyz);
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
    u_xlat16_29 = (-u_xlat9.x) + 1.0;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_6 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_14.x = (-u_xlat16_6) + _Smoothness;
    u_xlat16_14.x = u_xlat16_14.x + 1.0;
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0, 1.0);
    u_xlat16_7.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_14.xyz = u_xlat16_14.xxx + (-u_xlat16_7.xyz);
    u_xlat16_14.xyz = vec3(u_xlat16_29) * u_xlat16_14.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_14.xyz;
    u_xlat9.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat9.x = max(u_xlat9.x, 0.00100000005);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat9.xxx;
    u_xlat9.x = dot(_WorldSpaceLightPos0.xyz, u_xlat8.xyz);
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat8.xyz);
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
    u_xlat16 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
    u_xlat8.x = u_xlat8.x * u_xlat8.x;
    u_xlat24 = max(u_xlat9.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat24;
    u_xlat24 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat8.x = u_xlat8.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyw = _Color.xyz * vec3(u_xlat16_6) + u_xlat0.xyw;
    u_xlat0.xyw = u_xlat0.xyw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * vec3(u_xlat16) + u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD3;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
float u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_14;
float u_xlat16;
float u_xlat24;
float u_xlat27;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat8.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat9.xyz = u_xlat8.xyz * vec3(u_xlat1);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat9.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat9.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat27 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat27;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_29 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_29 = (-u_xlat16_29) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_29);
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat9.x = dot(u_xlat3.xyz, u_xlat9.xyz);
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
    u_xlat16_29 = (-u_xlat9.x) + 1.0;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_6 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_14.x = (-u_xlat16_6) + _Smoothness;
    u_xlat16_14.x = u_xlat16_14.x + 1.0;
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0, 1.0);
    u_xlat16_7.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_14.xyz = u_xlat16_14.xxx + (-u_xlat16_7.xyz);
    u_xlat16_14.xyz = vec3(u_xlat16_29) * u_xlat16_14.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_14.xyz;
    u_xlat9.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat9.x = max(u_xlat9.x, 0.00100000005);
    u_xlat9.x = inversesqrt(u_xlat9.x);
    u_xlat8.xyz = u_xlat8.xyz * u_xlat9.xxx;
    u_xlat9.x = dot(_WorldSpaceLightPos0.xyz, u_xlat8.xyz);
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat8.xyz);
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
    u_xlat16 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
    u_xlat8.x = u_xlat8.x * u_xlat8.x;
    u_xlat24 = max(u_xlat9.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat24;
    u_xlat24 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat8.x = u_xlat8.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyw = _Color.xyz * vec3(u_xlat16_6) + u_xlat0.xyw;
    u_xlat0.xyw = u_xlat0.xyw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * vec3(u_xlat16) + u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD3;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat27;
mediump float u_xlat16_28;
mediump float u_xlat16_30;
float u_xlat31;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_28 = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_28 = u_xlat16_28 + u_xlat16_28;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-vec3(u_xlat16_28)) + (-u_xlat0.xyz);
    u_xlat10_2 = textureCube(_HeuristicReflection, u_xlat16_2.xyz);
    u_xlat16_28 = u_xlat10_2.w + -1.0;
    u_xlat16_28 = unity_SpecCube0_HDR.w * u_xlat16_28 + 1.0;
    u_xlat16_28 = u_xlat16_28 * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(u_xlat16_28);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Occlusion);
    u_xlat27 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * vs_TEXCOORD0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat31 = u_xlat27;
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat0.xyz = u_xlat4.xyz * (-vec3(u_xlat27)) + u_xlat0.xyz;
    u_xlat27 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_28 = (-u_xlat31) + 1.0;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_9;
    u_xlat16_28 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_30 = (-u_xlat16_28) + _Smoothness;
    u_xlat16_6.xyz = vec3(u_xlat16_28) * _Color.xyz;
    u_xlat16_28 = u_xlat16_30 + 1.0;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_7.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_28) + (-u_xlat16_7.xyz);
    u_xlat16_8.xyz = vec3(u_xlat16_9) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz + u_xlat16_3.xyz;
    u_xlat0.z = (-_Smoothness) + 1.0;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD3;
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
mediump float u_xlat16_15;
float u_xlat18;
mediump float u_xlat16_19;
mediump float u_xlat16_20;
float u_xlat21;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_19 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = vec3(u_xlat16_19) * _Color.xyz;
    u_xlat16_19 = (-u_xlat16_19) + _Smoothness;
    u_xlat16_19 = u_xlat16_19 + 1.0;
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = max(u_xlat18, 0.00100000005);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat18 = dot(_WorldSpaceLightPos0.xyz, u_xlat3.xyz);
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlat18 = max(u_xlat18, 0.319999993);
    u_xlat16_21 = (-_Smoothness) + 1.0;
    u_xlat16_4 = u_xlat16_21 * u_xlat16_21 + 1.5;
    u_xlat18 = u_xlat18 * u_xlat16_4;
    u_xlat4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD0.xyz;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat16_9 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_20 = u_xlat16_21 * u_xlat16_9;
    u_xlat16_20 = (-u_xlat16_20) * 0.280000001 + 1.0;
    u_xlat16_15 = u_xlat16_9 * u_xlat16_9 + -1.0;
    u_xlat3.x = u_xlat3.x * u_xlat16_15 + 1.00001001;
    u_xlat18 = u_xlat18 * u_xlat3.x;
    u_xlat18 = u_xlat16_9 / u_xlat18;
    u_xlat18 = u_xlat18 + -9.99999975e-05;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = min(u_xlat18, 100.0);
    u_xlat16_5.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _LightColor0.xyz;
    u_xlat18 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat16_2.x = (-u_xlat21) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat18) + u_xlat16_1.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat10_0 = textureCube(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_20);
    u_xlat16_8.xyz = vec3(u_xlat16_19) + (-u_xlat16_5.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_8.xyz + u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat18 = vs_TEXCOORD3;
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
mediump float u_xlat16_15;
float u_xlat18;
mediump float u_xlat16_19;
mediump float u_xlat16_20;
float u_xlat21;
mediump float u_xlat16_21;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_19 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = vec3(u_xlat16_19) * _Color.xyz;
    u_xlat16_19 = (-u_xlat16_19) + _Smoothness;
    u_xlat16_19 = u_xlat16_19 + 1.0;
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = max(u_xlat18, 0.00100000005);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat18 = dot(_WorldSpaceLightPos0.xyz, u_xlat3.xyz);
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlat18 = max(u_xlat18, 0.319999993);
    u_xlat16_21 = (-_Smoothness) + 1.0;
    u_xlat16_4 = u_xlat16_21 * u_xlat16_21 + 1.5;
    u_xlat18 = u_xlat18 * u_xlat16_4;
    u_xlat4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD0.xyz;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat16_9 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_20 = u_xlat16_21 * u_xlat16_9;
    u_xlat16_20 = (-u_xlat16_20) * 0.280000001 + 1.0;
    u_xlat16_15 = u_xlat16_9 * u_xlat16_9 + -1.0;
    u_xlat3.x = u_xlat3.x * u_xlat16_15 + 1.00001001;
    u_xlat18 = u_xlat18 * u_xlat3.x;
    u_xlat18 = u_xlat16_9 / u_xlat18;
    u_xlat18 = u_xlat18 + -9.99999975e-05;
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = min(u_xlat18, 100.0);
    u_xlat16_5.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _LightColor0.xyz;
    u_xlat18 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat16_2.x = (-u_xlat21) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat18) + u_xlat16_1.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat10_0 = textureCube(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_20);
    u_xlat16_8.xyz = vec3(u_xlat16_19) + (-u_xlat16_5.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_8.xyz + u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat18 = vs_TEXCOORD3;
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_31;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_31 = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_31 = u_xlat16_31 + u_xlat16_31;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-vec3(u_xlat16_31)) + (-u_xlat0.xyz);
    u_xlat30 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb30 = u_xlat30<9.99999975e-06;
    u_xlat30 = (u_xlatb30) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat30 * u_xlat16_2.x;
    u_xlat4.x = u_xlat30 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat30 = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat30) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat4.z = (-_Smoothness) + 1.0;
    u_xlatb30 = u_xlat4.z<0.00499999989;
    u_xlat33 = u_xlat4.z * 8.29800034;
    u_xlat16_31 = (u_xlatb30) ? 0.0 : u_xlat33;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_31);
    u_xlat16_31 = u_xlat10_2.w + -1.0;
    u_xlat16_31 = unity_SpecCube0_HDR.w * u_xlat16_31 + 1.0;
    u_xlat16_31 = u_xlat16_31 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vec3(u_xlat16_31);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat30 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * vs_TEXCOORD0.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat33 = u_xlat30;
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat30)) + u_xlat0.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat30) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_31 = (-u_xlat33) + 1.0;
    u_xlat16_10 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_10 = u_xlat16_31 * u_xlat16_10;
    u_xlat16_10 = u_xlat16_31 * u_xlat16_10;
    u_xlat16_31 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_35 = (-u_xlat16_31) + _Smoothness;
    u_xlat16_7.xyz = vec3(u_xlat16_31) * _Color.xyz;
    u_xlat16_31 = u_xlat16_35 + 1.0;
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat16_8.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_9.xyz = vec3(u_xlat16_31) + (-u_xlat16_8.xyz);
    u_xlat16_9.xyz = vec3(u_xlat16_10) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_7.xyz + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_6.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD3;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * vec3(u_xlat1);
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_35) * _Color.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat2.xyz = vs_TEXCOORD0.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD3;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * vec3(u_xlat1);
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_35) * _Color.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat2.xyz = vs_TEXCOORD0.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD3;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
float u_xlat24;
mediump float u_xlat16_25;
mediump float u_xlat16_27;
float u_xlat28;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_25 = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_25 = u_xlat16_25 + u_xlat16_25;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-vec3(u_xlat16_25)) + (-u_xlat0.xyz);
    u_xlat10_2 = textureCube(_HeuristicReflection, u_xlat16_2.xyz);
    u_xlat16_25 = u_xlat10_2.w + -1.0;
    u_xlat16_25 = unity_SpecCube0_HDR.w * u_xlat16_25 + 1.0;
    u_xlat16_25 = u_xlat16_25 * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(u_xlat16_25);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Occlusion);
    u_xlat24 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * vs_TEXCOORD0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat28 = u_xlat24;
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat0.xyz = u_xlat4.xyz * (-vec3(u_xlat24)) + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_25 = (-u_xlat28) + 1.0;
    u_xlat16_8 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_8 = u_xlat16_25 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_25 * u_xlat16_8;
    u_xlat16_25 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_27 = (-u_xlat16_25) + _Smoothness;
    u_xlat16_5.xyz = vec3(u_xlat16_25) * _Color.xyz;
    u_xlat16_25 = u_xlat16_27 + 1.0;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_7.xyz = vec3(u_xlat16_25) + (-u_xlat16_6.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_7.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlat10_2 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_25 = dot(u_xlat10_2, unity_OcclusionMaskSelector);
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_3.xyz = vec3(u_xlat16_25) * _LightColor0.xyz;
    u_xlat16_3.xyz = vec3(u_xlat24) * u_xlat16_3.xyz;
    u_xlat0.z = (-_Smoothness) + 1.0;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_5.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD3;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
mediump float u_xlat16_18;
float u_xlat21;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
float u_xlat25;
mediump float u_xlat16_25;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_22 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = vec3(u_xlat16_22) * _Color.xyz;
    u_xlat16_22 = (-u_xlat16_22) + _Smoothness;
    u_xlat16_22 = u_xlat16_22 + 1.0;
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_23 = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * _LightColor0.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = max(u_xlat21, 0.00100000005);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat21 = max(u_xlat21, 0.319999993);
    u_xlat16_25 = (-_Smoothness) + 1.0;
    u_xlat16_5 = u_xlat16_25 * u_xlat16_25 + 1.5;
    u_xlat21 = u_xlat21 * u_xlat16_5;
    u_xlat5.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD0.xyz;
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat16_11 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_23 = u_xlat16_25 * u_xlat16_11;
    u_xlat16_23 = (-u_xlat16_23) * 0.280000001 + 1.0;
    u_xlat16_18 = u_xlat16_11 * u_xlat16_11 + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat16_18 + 1.00001001;
    u_xlat21 = u_xlat21 * u_xlat4.x;
    u_xlat21 = u_xlat16_11 / u_xlat21;
    u_xlat21 = u_xlat21 + -9.99999975e-05;
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat21 = min(u_xlat21, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat16_3.xyz * u_xlat4.xyz;
    u_xlat21 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat25 = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
    u_xlat16_2.x = (-u_xlat25) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat16_1.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat10_0 = textureCube(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_23);
    u_xlat16_9.xyz = vec3(u_xlat16_22) + (-u_xlat16_6.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_9.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat21 = vs_TEXCOORD3;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
mediump float u_xlat16_18;
float u_xlat21;
mediump float u_xlat16_22;
mediump float u_xlat16_23;
float u_xlat25;
mediump float u_xlat16_25;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_22 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = vec3(u_xlat16_22) * _Color.xyz;
    u_xlat16_22 = (-u_xlat16_22) + _Smoothness;
    u_xlat16_22 = u_xlat16_22 + 1.0;
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_23 = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * _LightColor0.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = max(u_xlat21, 0.00100000005);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat21 = max(u_xlat21, 0.319999993);
    u_xlat16_25 = (-_Smoothness) + 1.0;
    u_xlat16_5 = u_xlat16_25 * u_xlat16_25 + 1.5;
    u_xlat21 = u_xlat21 * u_xlat16_5;
    u_xlat5.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD0.xyz;
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat16_11 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_23 = u_xlat16_25 * u_xlat16_11;
    u_xlat16_23 = (-u_xlat16_23) * 0.280000001 + 1.0;
    u_xlat16_18 = u_xlat16_11 * u_xlat16_11 + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat16_18 + 1.00001001;
    u_xlat21 = u_xlat21 * u_xlat4.x;
    u_xlat21 = u_xlat16_11 / u_xlat21;
    u_xlat21 = u_xlat21 + -9.99999975e-05;
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat21 = min(u_xlat21, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat4.xyz = vec3(u_xlat21) * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat16_3.xyz * u_xlat4.xyz;
    u_xlat21 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat25 = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
    u_xlat16_2.x = (-u_xlat25) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat16_1.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat10_0 = textureCube(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_23);
    u_xlat16_9.xyz = vec3(u_xlat16_22) + (-u_xlat16_6.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_9.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat21 = vs_TEXCOORD3;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_28 = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_28 = u_xlat16_28 + u_xlat16_28;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-vec3(u_xlat16_28)) + (-u_xlat0.xyz);
    u_xlat27 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb27 = u_xlat27<9.99999975e-06;
    u_xlat27 = (u_xlatb27) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat27 * u_xlat16_2.x;
    u_xlat4.x = u_xlat27 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat27 = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat16_2.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat4.z = (-_Smoothness) + 1.0;
    u_xlatb27 = u_xlat4.z<0.00499999989;
    u_xlat30 = u_xlat4.z * 8.29800034;
    u_xlat16_28 = (u_xlatb27) ? 0.0 : u_xlat30;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_28);
    u_xlat16_28 = u_xlat10_2.w + -1.0;
    u_xlat16_28 = unity_SpecCube0_HDR.w * u_xlat16_28 + 1.0;
    u_xlat16_28 = u_xlat16_28 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * vec3(u_xlat16_28);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat27 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * vs_TEXCOORD0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat30 = u_xlat27;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat27)) + u_xlat0.xyz;
    u_xlat27 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = (-u_xlat30) + 1.0;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_9;
    u_xlat16_28 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_32 = (-u_xlat16_28) + _Smoothness;
    u_xlat16_6.xyz = vec3(u_xlat16_28) * _Color.xyz;
    u_xlat16_28 = u_xlat16_32 + 1.0;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_7.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_28) + (-u_xlat16_7.xyz);
    u_xlat16_8.xyz = vec3(u_xlat16_9) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat10_2 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_28 = dot(u_xlat10_2, unity_OcclusionMaskSelector);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat16_28) * _LightColor0.xyz;
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_7.xyz * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD3;
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * vec3(u_xlat1);
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_35) * _Color.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat10_2 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_35 = dot(u_xlat10_2, unity_OcclusionMaskSelector);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
    u_xlat16_9.xyz = vec3(u_xlat16_35) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat2.xyz = vs_TEXCOORD0.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD3;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * vec3(u_xlat1);
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_35) * _Color.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat10_2 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_35 = dot(u_xlat10_2, unity_OcclusionMaskSelector);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
    u_xlat16_9.xyz = vec3(u_xlat16_35) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat2.xyz = vs_TEXCOORD0.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD3;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
float u_xlat24;
mediump float u_xlat16_26;
float u_xlat27;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat10_1 = textureCube(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_2.x = u_xlat10_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Occlusion);
    u_xlat24 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * vs_TEXCOORD0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat27 = u_xlat24;
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat24)) + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat24) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_26 = (-u_xlat27) + 1.0;
    u_xlat16_8 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_8 = u_xlat16_26 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_26 * u_xlat16_8;
    u_xlat16_26 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_28 = (-u_xlat16_26) + _Smoothness;
    u_xlat16_5.xyz = vec3(u_xlat16_26) * _Color.xyz;
    u_xlat16_26 = u_xlat16_28 + 1.0;
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_7.xyz = vec3(u_xlat16_26) + (-u_xlat16_6.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Occlusion);
    u_xlat16_2.xyz = u_xlat16_7.xyz * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat0.z = (-_Smoothness) + 1.0;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_5.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xyz * u_xlat16_4.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD3;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_9;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_17;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_25;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat24 = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat24 = max(u_xlat24, 0.319999993);
    u_xlat16_25 = (-_Smoothness) + 1.0;
    u_xlat16_2 = u_xlat16_25 * u_xlat16_25 + 1.5;
    u_xlat24 = u_xlat24 * u_xlat16_2;
    u_xlat2.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD0.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_9 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_3 = u_xlat16_25 * u_xlat16_9;
    u_xlat16_3 = (-u_xlat16_3) * 0.280000001 + 1.0;
    u_xlat16_17 = u_xlat16_9 * u_xlat16_9 + -1.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_17 + 1.00001001;
    u_xlat24 = u_xlat24 * u_xlat1.x;
    u_xlat24 = u_xlat16_9 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_11.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_11.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_11.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_4.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_12.xyz = u_xlat16_4.xxx * _Color.xyz;
    u_xlat16_4.x = (-u_xlat16_4.x) + _Smoothness;
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_5.xyz = (-u_xlat16_11.xyz) + u_xlat16_4.xxx;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_11.xyz + u_xlat16_12.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = u_xlat16_12.xyz * u_xlat16_7.xyz;
    u_xlat24 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
    u_xlat16_28 = (-u_xlat25) + 1.0;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_11.xyz = vec3(u_xlat16_28) * u_xlat16_5.xyz + u_xlat16_11.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + u_xlat16_4.xyz;
    u_xlat16_4.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_4.x;
    u_xlat16_4.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_4.xxx) + (-u_xlat0.xyz);
    u_xlat10_0 = textureCube(_HeuristicReflection, u_xlat16_4.xyz);
    u_xlat16_4.x = u_xlat10_0.w + -1.0;
    u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = vec3(u_xlat16_3) * u_xlat16_4.xyz;
    u_xlat0.xyz = u_xlat16_4.xyz * u_xlat16_11.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD3;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_9;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_17;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_25;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    u_xlat24 = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat24 = max(u_xlat24, 0.319999993);
    u_xlat16_25 = (-_Smoothness) + 1.0;
    u_xlat16_2 = u_xlat16_25 * u_xlat16_25 + 1.5;
    u_xlat24 = u_xlat24 * u_xlat16_2;
    u_xlat2.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD0.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_9 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_3 = u_xlat16_25 * u_xlat16_9;
    u_xlat16_3 = (-u_xlat16_3) * 0.280000001 + 1.0;
    u_xlat16_17 = u_xlat16_9 * u_xlat16_9 + -1.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_17 + 1.00001001;
    u_xlat24 = u_xlat24 * u_xlat1.x;
    u_xlat24 = u_xlat16_9 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_11.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_11.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_11.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_4.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_12.xyz = u_xlat16_4.xxx * _Color.xyz;
    u_xlat16_4.x = (-u_xlat16_4.x) + _Smoothness;
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_5.xyz = (-u_xlat16_11.xyz) + u_xlat16_4.xxx;
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_11.xyz + u_xlat16_12.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat16_6.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = u_xlat16_12.xyz * u_xlat16_7.xyz;
    u_xlat24 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
    u_xlat16_28 = (-u_xlat25) + 1.0;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_11.xyz = vec3(u_xlat16_28) * u_xlat16_5.xyz + u_xlat16_11.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat24) + u_xlat16_4.xyz;
    u_xlat16_4.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_4.x;
    u_xlat16_4.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_4.xxx) + (-u_xlat0.xyz);
    u_xlat10_0 = textureCube(_HeuristicReflection, u_xlat16_4.xyz);
    u_xlat16_4.x = u_xlat10_0.w + -1.0;
    u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = vec3(u_xlat16_3) * u_xlat16_4.xyz;
    u_xlat0.xyz = u_xlat16_4.xyz * u_xlat16_11.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD3;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat27;
bool u_xlatb27;
float u_xlat29;
mediump float u_xlat16_31;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat27 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb27 = u_xlat27<9.99999975e-06;
    u_xlat27 = (u_xlatb27) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat2.z = u_xlat27 * u_xlat16_1.x;
    u_xlat3.x = u_xlat27 * u_xlat16_1.z;
    u_xlat2.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat3.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat27 = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat27) + u_xlat16_1.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat3.z = (-_Smoothness) + 1.0;
    u_xlatb27 = u_xlat3.z<0.00499999989;
    u_xlat29 = u_xlat3.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb27) ? 0.0 : u_xlat29;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_4.x = u_xlat10_1.w + -1.0;
    u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat27 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * vs_TEXCOORD0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat29 = u_xlat27;
    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat27)) + u_xlat0.xyz;
    u_xlat27 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat3.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_31 = (-u_xlat29) + 1.0;
    u_xlat16_9 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_9 = u_xlat16_31 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_31 * u_xlat16_9;
    u_xlat16_31 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_32 = (-u_xlat16_31) + _Smoothness;
    u_xlat16_6.xyz = vec3(u_xlat16_31) * _Color.xyz;
    u_xlat16_31 = u_xlat16_32 + 1.0;
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat16_7.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_31) + (-u_xlat16_7.xyz);
    u_xlat16_8.xyz = vec3(u_xlat16_9) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = u_xlat16_8.xyz * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_7.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD3;
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * vec3(u_xlat1);
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_35) * _Color.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_4.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD3;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * vec3(u_xlat1);
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_35) * _Color.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_4.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD3;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_12;
mediump float u_xlat16_27;
mediump float u_xlat16_29;
float u_xlat30;
float u_xlat31;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0.x = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat16_27 = dot((-u_xlat3.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_27 = u_xlat16_27 + u_xlat16_27;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-vec3(u_xlat16_27)) + (-u_xlat3.xyz);
    u_xlat10_1 = textureCube(_HeuristicReflection, u_xlat16_2.xyz);
    u_xlat16_27 = u_xlat10_1.w + -1.0;
    u_xlat16_27 = unity_SpecCube0_HDR.w * u_xlat16_27 + 1.0;
    u_xlat16_27 = u_xlat16_27 * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(u_xlat16_27);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Occlusion);
    u_xlat30 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat4.xyz = vec3(u_xlat30) * vs_TEXCOORD0.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat31 = u_xlat30;
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat3.xyz = u_xlat4.xyz * (-vec3(u_xlat30)) + u_xlat3.xyz;
    u_xlat30 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat30) * _LightColor0.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat16_27 = (-u_xlat31) + 1.0;
    u_xlat16_12 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_12 = u_xlat16_27 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_27 * u_xlat16_12;
    u_xlat16_27 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_29 = (-u_xlat16_27) + _Smoothness;
    u_xlat16_6.xyz = vec3(u_xlat16_27) * _Color.xyz;
    u_xlat16_27 = u_xlat16_29 + 1.0;
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
    u_xlat16_7.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_27) + (-u_xlat16_7.xyz);
    u_xlat16_8.xyz = vec3(u_xlat16_12) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat3.z = (-_Smoothness) + 1.0;
    u_xlat3.x = texture2D(unity_NHxRoughness, u_xlat3.xz).x;
    u_xlat3.x = u_xlat3.x * 16.0;
    u_xlat16_2.xyz = u_xlat3.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz + u_xlat16_0.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD3;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
mediump float u_xlat16_18;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_25;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0.x = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_21 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = vec3(u_xlat16_21) * _Color.xyz;
    u_xlat16_21 = (-u_xlat16_21) + _Smoothness;
    u_xlat16_21 = u_xlat16_21 + 1.0;
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
    u_xlat24 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat24 = max(u_xlat24, 0.319999993);
    u_xlat16_25 = (-_Smoothness) + 1.0;
    u_xlat16_5 = u_xlat16_25 * u_xlat16_25 + 1.5;
    u_xlat24 = u_xlat24 * u_xlat16_5;
    u_xlat5.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD0.xyz;
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat16_11 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_23 = u_xlat16_25 * u_xlat16_11;
    u_xlat16_23 = (-u_xlat16_23) * 0.280000001 + 1.0;
    u_xlat16_18 = u_xlat16_11 * u_xlat16_11 + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat16_18 + 1.00001001;
    u_xlat24 = u_xlat24 * u_xlat4.x;
    u_xlat24 = u_xlat16_11 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _LightColor0.xyz;
    u_xlat24 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat25 = dot(u_xlat5.xyz, u_xlat3.xyz);
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
    u_xlat16_2.x = (-u_xlat25) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat24) + u_xlat16_0.xyz;
    u_xlat16_0.x = dot((-u_xlat3.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_0.xxx) + (-u_xlat3.xyz);
    u_xlat10_1 = textureCube(_HeuristicReflection, u_xlat16_0.xyz);
    u_xlat16_0.x = u_xlat10_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_23);
    u_xlat16_9.xyz = vec3(u_xlat16_21) + (-u_xlat16_6.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_9.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD3;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
mediump float u_xlat16_18;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_25;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0.x = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_21 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = vec3(u_xlat16_21) * _Color.xyz;
    u_xlat16_21 = (-u_xlat16_21) + _Smoothness;
    u_xlat16_21 = u_xlat16_21 + 1.0;
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat4.xyz;
    u_xlat24 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat24 = max(u_xlat24, 0.319999993);
    u_xlat16_25 = (-_Smoothness) + 1.0;
    u_xlat16_5 = u_xlat16_25 * u_xlat16_25 + 1.5;
    u_xlat24 = u_xlat24 * u_xlat16_5;
    u_xlat5.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD0.xyz;
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat4.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat16_11 = u_xlat16_25 * u_xlat16_25;
    u_xlat16_23 = u_xlat16_25 * u_xlat16_11;
    u_xlat16_23 = (-u_xlat16_23) * 0.280000001 + 1.0;
    u_xlat16_18 = u_xlat16_11 * u_xlat16_11 + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat16_18 + 1.00001001;
    u_xlat24 = u_xlat24 * u_xlat4.x;
    u_xlat24 = u_xlat16_11 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat4.xyz = vec3(u_xlat24) * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _LightColor0.xyz;
    u_xlat24 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat25 = dot(u_xlat5.xyz, u_xlat3.xyz);
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
    u_xlat16_2.x = (-u_xlat25) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat24) + u_xlat16_0.xyz;
    u_xlat16_0.x = dot((-u_xlat3.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_0.xxx) + (-u_xlat3.xyz);
    u_xlat10_1 = textureCube(_HeuristicReflection, u_xlat16_0.xyz);
    u_xlat16_0.x = u_xlat10_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_23);
    u_xlat16_9.xyz = vec3(u_xlat16_21) + (-u_xlat16_6.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_9.xyz + u_xlat16_6.xyz;
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD3;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_13;
mediump float u_xlat16_30;
mediump float u_xlat16_32;
float u_xlat33;
bool u_xlatb33;
float u_xlat34;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0.x = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat3.xyz = vec3(u_xlat33) * u_xlat3.xyz;
    u_xlat16_30 = dot((-u_xlat3.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_30 = u_xlat16_30 + u_xlat16_30;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-vec3(u_xlat16_30)) + (-u_xlat3.xyz);
    u_xlat33 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb33 = u_xlat33<9.99999975e-06;
    u_xlat33 = (u_xlatb33) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat16_2.x * u_xlat33;
    u_xlat5.x = u_xlat16_2.z * u_xlat33;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat5.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat33 = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * _NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33) + u_xlat16_2.xyz;
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz;
    u_xlat5.z = (-_Smoothness) + 1.0;
    u_xlatb33 = u_xlat5.z<0.00499999989;
    u_xlat34 = u_xlat5.z * 8.29800034;
    u_xlat16_30 = (u_xlatb33) ? 0.0 : u_xlat34;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat4.xyz, u_xlat16_30);
    u_xlat16_30 = u_xlat10_1.w + -1.0;
    u_xlat16_30 = unity_SpecCube0_HDR.w * u_xlat16_30 + 1.0;
    u_xlat16_30 = u_xlat16_30 * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(u_xlat16_30);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Occlusion);
    u_xlat33 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * vs_TEXCOORD0.xyz;
    u_xlat33 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat34 = u_xlat33;
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat3.xyz = u_xlat4.xyz * (-vec3(u_xlat33)) + u_xlat3.xyz;
    u_xlat33 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat33) * _LightColor0.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat5.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = texture2D(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat3.x = u_xlat3.x * 16.0;
    u_xlat16_30 = (-u_xlat34) + 1.0;
    u_xlat16_13 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_13 = u_xlat16_30 * u_xlat16_13;
    u_xlat16_13 = u_xlat16_30 * u_xlat16_13;
    u_xlat16_30 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_32 = (-u_xlat16_30) + _Smoothness;
    u_xlat16_7.xyz = vec3(u_xlat16_30) * _Color.xyz;
    u_xlat16_30 = u_xlat16_32 + 1.0;
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
    u_xlat16_8.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_9.xyz = vec3(u_xlat16_30) + (-u_xlat16_8.xyz);
    u_xlat16_9.xyz = vec3(u_xlat16_13) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat3.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_9.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_8.xyz * u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD3;
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
    u_xlat3.xyz = vec3(u_xlat33) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat24;
float u_xlat36;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat13.xyz = u_xlat12.xyz * vec3(u_xlat1);
    u_xlat12.xyz = u_xlat12.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat13.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat13.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat39 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat39;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_41 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat12.xyz = u_xlat12.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat12.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
    u_xlat12.x = u_xlat12.x * u_xlat12.x;
    u_xlat24 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat12.x = u_xlat12.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_41) * _Color.xyz;
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_41);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_41 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_41 = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_41);
    u_xlat16_2 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_41) + u_xlat16_9.xyz;
    u_xlat2.xyz = vs_TEXCOORD0.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_11.xyz + u_xlat16_4.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat13.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat16_41 = (-u_xlat1) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = vec3(u_xlat16_41) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD3;
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D unity_Lightmap;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat24;
float u_xlat36;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat13.xyz = u_xlat12.xyz * vec3(u_xlat1);
    u_xlat12.xyz = u_xlat12.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat13.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat13.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat39 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat39;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_41 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat12.xyz = u_xlat12.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat12.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
    u_xlat12.x = u_xlat12.x * u_xlat12.x;
    u_xlat24 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat12.x = u_xlat12.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_41) * _Color.xyz;
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_41);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_41 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_41 = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_41);
    u_xlat16_2 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_41) + u_xlat16_9.xyz;
    u_xlat2.xyz = vs_TEXCOORD0.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_11.xyz + u_xlat16_4.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat13.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat16_41 = (-u_xlat1) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = vec3(u_xlat16_41) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD3;
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_11;
float u_xlat21;
mediump float u_xlat16_23;
float u_xlat24;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat10_1 = textureCube(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_2.x = u_xlat10_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Occlusion);
    u_xlat21 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * vs_TEXCOORD0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat24 = u_xlat21;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat21)) + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_23 = (-u_xlat24) + 1.0;
    u_xlat16_7 = u_xlat16_23 * u_xlat16_23;
    u_xlat16_7 = u_xlat16_23 * u_xlat16_7;
    u_xlat16_7 = u_xlat16_23 * u_xlat16_7;
    u_xlat16_23 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_4.x = (-u_xlat16_23) + _Smoothness;
    u_xlat16_11.xyz = vec3(u_xlat16_23) * _Color.xyz;
    u_xlat16_23 = u_xlat16_4.x + 1.0;
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
    u_xlat16_5.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_6.xyz = vec3(u_xlat16_23) + (-u_xlat16_5.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_7) * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    u_xlat16_3.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(_Occlusion);
    u_xlat16_2.xyz = u_xlat16_6.xyz * u_xlat16_11.xyz + u_xlat16_2.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_23 = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
    u_xlat16_6.xyz = vec3(u_xlat16_23) * _LightColor0.xyz;
    u_xlat16_6.xyz = vec3(u_xlat21) * u_xlat16_6.xyz;
    u_xlat0.z = (-_Smoothness) + 1.0;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_11.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat21 = vs_TEXCOORD3;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_10;
mediump float u_xlat16_18;
float u_xlat24;
mediump float u_xlat16_25;
float u_xlat26;
mediump float u_xlat16_26;
mediump float u_xlat16_28;
void main()
{
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_1.x = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat24 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat24 = max(u_xlat24, 0.319999993);
    u_xlat16_26 = (-_Smoothness) + 1.0;
    u_xlat16_3 = u_xlat16_26 * u_xlat16_26 + 1.5;
    u_xlat24 = u_xlat24 * u_xlat16_3;
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_25 = u_xlat16_26 * u_xlat16_10;
    u_xlat16_25 = (-u_xlat16_25) * 0.280000001 + 1.0;
    u_xlat16_18 = u_xlat16_10 * u_xlat16_10 + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat16_18 + 1.00001001;
    u_xlat24 = u_xlat24 * u_xlat2.x;
    u_xlat24 = u_xlat16_10 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_4.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_28 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.xyz = vec3(u_xlat16_28) * _Color.xyz;
    u_xlat16_28 = (-u_xlat16_28) + _Smoothness;
    u_xlat16_28 = u_xlat16_28 + 1.0;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_28);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat16_4.xyz + u_xlat16_5.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    u_xlat16_7.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_7.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat16_28 = (-u_xlat26) + 1.0;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_4.xyz = vec3(u_xlat16_28) * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat10_0 = textureCube(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD3;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_10;
mediump float u_xlat16_18;
float u_xlat24;
mediump float u_xlat16_25;
float u_xlat26;
mediump float u_xlat16_26;
mediump float u_xlat16_28;
void main()
{
    u_xlat10_0 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_1.x = dot(u_xlat10_0, unity_OcclusionMaskSelector);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat24 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat24 = max(u_xlat24, 0.319999993);
    u_xlat16_26 = (-_Smoothness) + 1.0;
    u_xlat16_3 = u_xlat16_26 * u_xlat16_26 + 1.5;
    u_xlat24 = u_xlat24 * u_xlat16_3;
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_25 = u_xlat16_26 * u_xlat16_10;
    u_xlat16_25 = (-u_xlat16_25) * 0.280000001 + 1.0;
    u_xlat16_18 = u_xlat16_10 * u_xlat16_10 + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat16_18 + 1.00001001;
    u_xlat24 = u_xlat24 * u_xlat2.x;
    u_xlat24 = u_xlat16_10 / u_xlat24;
    u_xlat24 = u_xlat24 + -9.99999975e-05;
    u_xlat24 = max(u_xlat24, 0.0);
    u_xlat24 = min(u_xlat24, 100.0);
    u_xlat16_4.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_28 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.xyz = vec3(u_xlat16_28) * _Color.xyz;
    u_xlat16_28 = (-u_xlat16_28) + _Smoothness;
    u_xlat16_28 = u_xlat16_28 + 1.0;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_6.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_28);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat16_4.xyz + u_xlat16_5.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    u_xlat16_7.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_7.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat16_28 = (-u_xlat26) + 1.0;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_4.xyz = vec3(u_xlat16_28) * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat10_0 = textureCube(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_1.x = u_xlat10_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_25);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD3;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_13;
float u_xlat24;
bool u_xlatb24;
float u_xlat26;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
    u_xlatb24 = u_xlat24<9.99999975e-06;
    u_xlat24 = (u_xlatb24) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat2.z = u_xlat24 * u_xlat16_1.x;
    u_xlat3.x = u_xlat24 * u_xlat16_1.z;
    u_xlat2.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat3.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat24 = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat3.z = (-_Smoothness) + 1.0;
    u_xlatb24 = u_xlat3.z<0.00499999989;
    u_xlat26 = u_xlat3.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb24) ? 0.0 : u_xlat26;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_4.x = u_xlat10_1.w + -1.0;
    u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat24 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * vs_TEXCOORD0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat26 = u_xlat24;
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat24)) + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat3.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = (-u_xlat26) + 1.0;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_28 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.x = (-u_xlat16_28) + _Smoothness;
    u_xlat16_13.xyz = vec3(u_xlat16_28) * _Color.xyz;
    u_xlat16_28 = u_xlat16_5.x + 1.0;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_7.xyz = vec3(u_xlat16_28) + (-u_xlat16_6.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_13.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_0.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = u_xlat16_7.xyz * u_xlat16_13.xyz + u_xlat16_4.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_28 = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat16_28) * _LightColor0.xyz;
    u_xlat16_5.xyz = vec3(u_xlat24) * u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD3;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * vec3(u_xlat1);
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_35) * _Color.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat10_2 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_35 = dot(u_xlat10_2, unity_OcclusionMaskSelector);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
    u_xlat16_9.xyz = vec3(u_xlat16_35) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat16_4.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD3;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * vec3(u_xlat1);
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_35) * _Color.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat10_2 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_35 = dot(u_xlat10_2, unity_OcclusionMaskSelector);
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
    u_xlat16_9.xyz = vec3(u_xlat16_35) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat16_4.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD3;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_11;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
float u_xlat27;
float u_xlat28;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0.x = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat16_24 = dot((-u_xlat3.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_24 = u_xlat16_24 + u_xlat16_24;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-vec3(u_xlat16_24)) + (-u_xlat3.xyz);
    u_xlat10_1 = textureCube(_HeuristicReflection, u_xlat16_2.xyz);
    u_xlat16_24 = u_xlat10_1.w + -1.0;
    u_xlat16_24 = unity_SpecCube0_HDR.w * u_xlat16_24 + 1.0;
    u_xlat16_24 = u_xlat16_24 * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(u_xlat16_24);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Occlusion);
    u_xlat27 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * vs_TEXCOORD0.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat28 = u_xlat27;
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat3.xyz = u_xlat4.xyz * (-vec3(u_xlat27)) + u_xlat3.xyz;
    u_xlat27 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat3.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat16_24 = (-u_xlat28) + 1.0;
    u_xlat16_11 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_11 = u_xlat16_24 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_24 * u_xlat16_11;
    u_xlat16_24 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_26 = (-u_xlat16_24) + _Smoothness;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_24 = u_xlat16_26 + 1.0;
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_7.xyz = vec3(u_xlat16_24) + (-u_xlat16_6.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_11) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_24 = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_24) * _LightColor0.xyz;
    u_xlat16_2.xyz = vec3(u_xlat27) * u_xlat16_2.xyz;
    u_xlat3.z = (-_Smoothness) + 1.0;
    u_xlat3.x = texture2D(unity_NHxRoughness, u_xlat3.xz).x;
    u_xlat3.x = u_xlat3.x * 16.0;
    u_xlat16_5.xyz = u_xlat3.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_0.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD3;
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_12;
mediump float u_xlat16_20;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_28;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0.x = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_24 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_24 = (-u_xlat16_24) + _Smoothness;
    u_xlat16_24 = u_xlat16_24 + 1.0;
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_26 = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * _LightColor0.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat27 = max(u_xlat27, 0.319999993);
    u_xlat16_28 = (-_Smoothness) + 1.0;
    u_xlat16_6 = u_xlat16_28 * u_xlat16_28 + 1.5;
    u_xlat27 = u_xlat27 * u_xlat16_6;
    u_xlat6.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * vs_TEXCOORD0.xyz;
    u_xlat4.x = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat16_12 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_26 = u_xlat16_28 * u_xlat16_12;
    u_xlat16_26 = (-u_xlat16_26) * 0.280000001 + 1.0;
    u_xlat16_20 = u_xlat16_12 * u_xlat16_12 + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat16_20 + 1.00001001;
    u_xlat27 = u_xlat27 * u_xlat4.x;
    u_xlat27 = u_xlat16_12 / u_xlat27;
    u_xlat27 = u_xlat27 + -9.99999975e-05;
    u_xlat27 = max(u_xlat27, 0.0);
    u_xlat27 = min(u_xlat27, 100.0);
    u_xlat16_7.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat16_7.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat16_5.xyz * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat28 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat16_2.x = (-u_xlat28) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat16_0.xyz;
    u_xlat16_0.x = dot((-u_xlat3.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_0.xxx) + (-u_xlat3.xyz);
    u_xlat10_1 = textureCube(_HeuristicReflection, u_xlat16_0.xyz);
    u_xlat16_0.x = u_xlat10_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_26);
    u_xlat16_10.xyz = vec3(u_xlat16_24) + (-u_xlat16_7.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_10.xyz + u_xlat16_7.xyz;
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD3;
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_12;
mediump float u_xlat16_20;
mediump float u_xlat16_24;
mediump float u_xlat16_26;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_28;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0.x = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_24 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = vec3(u_xlat16_24) * _Color.xyz;
    u_xlat16_24 = (-u_xlat16_24) + _Smoothness;
    u_xlat16_24 = u_xlat16_24 + 1.0;
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_26 = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat16_26) * _LightColor0.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat27 = max(u_xlat27, 0.319999993);
    u_xlat16_28 = (-_Smoothness) + 1.0;
    u_xlat16_6 = u_xlat16_28 * u_xlat16_28 + 1.5;
    u_xlat27 = u_xlat27 * u_xlat16_6;
    u_xlat6.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * vs_TEXCOORD0.xyz;
    u_xlat4.x = dot(u_xlat6.xyz, u_xlat4.xyz);
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat16_12 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_26 = u_xlat16_28 * u_xlat16_12;
    u_xlat16_26 = (-u_xlat16_26) * 0.280000001 + 1.0;
    u_xlat16_20 = u_xlat16_12 * u_xlat16_12 + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat16_20 + 1.00001001;
    u_xlat27 = u_xlat27 * u_xlat4.x;
    u_xlat27 = u_xlat16_12 / u_xlat27;
    u_xlat27 = u_xlat27 + -9.99999975e-05;
    u_xlat27 = max(u_xlat27, 0.0);
    u_xlat27 = min(u_xlat27, 100.0);
    u_xlat16_7.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat16_7.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat16_5.xyz * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat28 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
    u_xlat16_2.x = (-u_xlat28) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat16_0.xyz;
    u_xlat16_0.x = dot((-u_xlat3.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_0.xxx) + (-u_xlat3.xyz);
    u_xlat10_1 = textureCube(_HeuristicReflection, u_xlat16_0.xyz);
    u_xlat16_0.x = u_xlat10_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_26);
    u_xlat16_10.xyz = vec3(u_xlat16_24) + (-u_xlat16_7.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_10.xyz + u_xlat16_7.xyz;
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD3;
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_12;
mediump float u_xlat16_27;
mediump float u_xlat16_29;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0.x = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat3.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat16_27 = dot((-u_xlat3.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_27 = u_xlat16_27 + u_xlat16_27;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-vec3(u_xlat16_27)) + (-u_xlat3.xyz);
    u_xlat30 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb30 = u_xlat30<9.99999975e-06;
    u_xlat30 = (u_xlatb30) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat16_2.x * u_xlat30;
    u_xlat5.x = u_xlat16_2.z * u_xlat30;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat5.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat30 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat30 = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat30) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz;
    u_xlat5.z = (-_Smoothness) + 1.0;
    u_xlatb30 = u_xlat5.z<0.00499999989;
    u_xlat31 = u_xlat5.z * 8.29800034;
    u_xlat16_27 = (u_xlatb30) ? 0.0 : u_xlat31;
    u_xlat10_1 = textureCube(unity_SpecCube0, u_xlat4.xyz, u_xlat16_27);
    u_xlat16_27 = u_xlat10_1.w + -1.0;
    u_xlat16_27 = unity_SpecCube0_HDR.w * u_xlat16_27 + 1.0;
    u_xlat16_27 = u_xlat16_27 * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(u_xlat16_27);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Occlusion);
    u_xlat30 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat4.xyz = vec3(u_xlat30) * vs_TEXCOORD0.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat31 = u_xlat30;
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat3.xyz = u_xlat4.xyz * (-vec3(u_xlat30)) + u_xlat3.xyz;
    u_xlat30 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat3.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat5.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = texture2D(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat3.x = u_xlat3.x * 16.0;
    u_xlat16_27 = (-u_xlat31) + 1.0;
    u_xlat16_12 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_12 = u_xlat16_27 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_27 * u_xlat16_12;
    u_xlat16_27 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_29 = (-u_xlat16_27) + _Smoothness;
    u_xlat16_6.xyz = vec3(u_xlat16_27) * _Color.xyz;
    u_xlat16_27 = u_xlat16_29 + 1.0;
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
    u_xlat16_7.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_27) + (-u_xlat16_7.xyz);
    u_xlat16_8.xyz = vec3(u_xlat16_12) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat3.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat10_1 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_27 = dot(u_xlat10_1, unity_OcclusionMaskSelector);
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_27) * _LightColor0.xyz;
    u_xlat16_2.xyz = vec3(u_xlat30) * u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_7.xyz * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD3;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat24;
float u_xlat36;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat13.xyz = u_xlat12.xyz * vec3(u_xlat1);
    u_xlat12.xyz = u_xlat12.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat13.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat13.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat39 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat39;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_41 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat12.xyz = u_xlat12.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat12.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
    u_xlat12.x = u_xlat12.x * u_xlat12.x;
    u_xlat24 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat12.x = u_xlat12.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_41) * _Color.xyz;
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_41);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat10_2 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_41 = dot(u_xlat10_2, unity_OcclusionMaskSelector);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_9.xyz = vec3(u_xlat16_41) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat16_41 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_41 = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_41);
    u_xlat16_2 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_41) + u_xlat16_9.xyz;
    u_xlat2.xyz = vs_TEXCOORD0.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_11.xyz + u_xlat16_4.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat13.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat16_41 = (-u_xlat1) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = vec3(u_xlat16_41) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD3;
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD1;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D unity_Lightmap;
uniform lowp sampler2D unity_ShadowMask;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat24;
float u_xlat36;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat13.xyz = u_xlat12.xyz * vec3(u_xlat1);
    u_xlat12.xyz = u_xlat12.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat13.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat13.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
    u_xlatb1 = u_xlat1<9.99999975e-06;
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
    u_xlatb1 = u_xlat0.x<0.00499999989;
    u_xlat39 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat39;
    u_xlat10_2 = textureCube(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat10_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_41 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat12.xyz = u_xlat12.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat12.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD0.xyz;
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
    u_xlat12.x = u_xlat12.x * u_xlat12.x;
    u_xlat24 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat12.x = u_xlat12.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_41) * _Color.xyz;
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_41);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat10_2 = texture2D(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_41 = dot(u_xlat10_2, unity_OcclusionMaskSelector);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_9.xyz = vec3(u_xlat16_41) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat16_41 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_41 = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_41);
    u_xlat16_2 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_41) + u_xlat16_9.xyz;
    u_xlat2.xyz = vs_TEXCOORD0.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = texture2D(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_11.xyz + u_xlat16_4.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat13.xyz);
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat16_41 = (-u_xlat1) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = vec3(u_xlat16_41) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD3;
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform highp sampler2D unity_NHxRoughness;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_7;
float u_xlat21;
mediump float u_xlat16_23;
float u_xlat24;
mediump float u_xlat16_25;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat10_1 = textureCube(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_2.x = u_xlat10_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Occlusion);
    u_xlat21 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * vs_TEXCOORD0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat24 = u_xlat21;
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat21)) + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat21) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_23 = (-u_xlat24) + 1.0;
    u_xlat16_7 = u_xlat16_23 * u_xlat16_23;
    u_xlat16_7 = u_xlat16_23 * u_xlat16_7;
    u_xlat16_7 = u_xlat16_23 * u_xlat16_7;
    u_xlat16_23 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_25 = (-u_xlat16_23) + _Smoothness;
    u_xlat16_25 = u_xlat16_25 + 1.0;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_5.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_6.xyz = vec3(u_xlat16_25) + (-u_xlat16_5.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_7) * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    u_xlat0.z = (-_Smoothness) + 1.0;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat0.xxx;
    u_xlat16_5.xyz = _Color.xyz * vec3(u_xlat16_23) + u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xyz * u_xlat16_4.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat21 = vs_TEXCOORD3;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_12;
float u_xlat14;
float u_xlat21;
mediump float u_xlat16_21;
mediump float u_xlat16_22;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat1.xyz);
    u_xlat10_2 = textureCube(_HeuristicReflection, u_xlat16_2.xyz);
    u_xlat16_3.x = u_xlat10_2.w + -1.0;
    u_xlat16_3.x = unity_SpecCube0_HDR.w * u_xlat16_3.x + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat10_2.xyz * u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Occlusion);
    u_xlat16_21 = (-_Smoothness) + 1.0;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_24 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21 + 1.5;
    u_xlat16_24 = (-u_xlat16_24) * 0.280000001 + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_24);
    u_xlat4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_24 = (-u_xlat1.x) + 1.0;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_5 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_12.x = (-u_xlat16_5) + _Smoothness;
    u_xlat16_12.x = u_xlat16_12.x + 1.0;
    u_xlat16_12.x = clamp(u_xlat16_12.x, 0.0, 1.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_12.xyz = u_xlat16_12.xxx + (-u_xlat16_6.xyz);
    u_xlat16_12.xyz = vec3(u_xlat16_24) * u_xlat16_12.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_12.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat14 = max(u_xlat1.x, 0.319999993);
    u_xlat14 = u_xlat16_21 * u_xlat14;
    u_xlat16_21 = u_xlat16_22 * u_xlat16_22 + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_21 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat14;
    u_xlat0.x = u_xlat16_22 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xzw = u_xlat16_6.xyz * u_xlat0.xxx;
    u_xlat0.xzw = _Color.xyz * vec3(u_xlat16_5) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xzw * vec3(u_xlat7) + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat21 = vs_TEXCOORD3;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform lowp samplerCube _HeuristicReflection;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump vec3 u_xlat16_12;
float u_xlat14;
float u_xlat21;
mediump float u_xlat16_21;
mediump float u_xlat16_22;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat1.xyz), vs_TEXCOORD0.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD0.xyz * (-u_xlat16_2.xxx) + (-u_xlat1.xyz);
    u_xlat10_2 = textureCube(_HeuristicReflection, u_xlat16_2.xyz);
    u_xlat16_3.x = u_xlat10_2.w + -1.0;
    u_xlat16_3.x = unity_SpecCube0_HDR.w * u_xlat16_3.x + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat10_2.xyz * u_xlat16_3.xxx;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Occlusion);
    u_xlat16_21 = (-_Smoothness) + 1.0;
    u_xlat16_22 = u_xlat16_21 * u_xlat16_21;
    u_xlat16_24 = u_xlat16_21 * u_xlat16_22;
    u_xlat16_21 = u_xlat16_21 * u_xlat16_21 + 1.5;
    u_xlat16_24 = (-u_xlat16_24) * 0.280000001 + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_24);
    u_xlat4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat16_24 = (-u_xlat1.x) + 1.0;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_5 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_12.x = (-u_xlat16_5) + _Smoothness;
    u_xlat16_12.x = u_xlat16_12.x + 1.0;
    u_xlat16_12.x = clamp(u_xlat16_12.x, 0.0, 1.0);
    u_xlat16_6.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_12.xyz = u_xlat16_12.xxx + (-u_xlat16_6.xyz);
    u_xlat16_12.xyz = vec3(u_xlat16_24) * u_xlat16_12.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_12.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat7 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat14 = max(u_xlat1.x, 0.319999993);
    u_xlat14 = u_xlat16_21 * u_xlat14;
    u_xlat16_21 = u_xlat16_22 * u_xlat16_22 + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_21 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat14;
    u_xlat0.x = u_xlat16_22 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xzw = u_xlat16_6.xyz * u_xlat0.xxx;
    u_xlat0.xzw = _Color.xyz * vec3(u_xlat16_5) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xzw * vec3(u_xlat7) + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat21 = vs_TEXCOORD3;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
}
}
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDADD" "RenderType" = "Opaque" }
  ZWrite Off
  GpuProgramID 105577
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform highp sampler2D unity_NHxRoughness;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat1.xyz * (-vec3(u_xlat12)) + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.y = (-_Smoothness) + 1.0;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_3.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat16_14 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_3.xyz = _Color.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
float u_xlat9;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 0.00100000005);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
    u_xlat9 = max(u_xlat9, 0.319999993);
    u_xlat16_1 = (-_Smoothness) + 1.0;
    u_xlat16_4 = u_xlat16_1 * u_xlat16_1 + 1.5;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat9 = u_xlat9 * u_xlat16_4;
    u_xlat4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_6 = u_xlat16_1 * u_xlat16_1 + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_6 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = u_xlat16_1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_2.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat16_2.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = _Color.xyz * u_xlat16_2.xxx + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xzw;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
float u_xlat9;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 0.00100000005);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
    u_xlat9 = max(u_xlat9, 0.319999993);
    u_xlat16_1 = (-_Smoothness) + 1.0;
    u_xlat16_4 = u_xlat16_1 * u_xlat16_1 + 1.5;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat9 = u_xlat9 * u_xlat16_4;
    u_xlat4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_6 = u_xlat16_1 * u_xlat16_1 + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_6 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = u_xlat16_1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_2.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat16_2.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = _Color.xyz * u_xlat16_2.xxx + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xzw;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform highp sampler2D unity_NHxRoughness;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat1.xyz * (-vec3(u_xlat12)) + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.y = (-_Smoothness) + 1.0;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_3.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat16_14 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_3.xyz = _Color.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
float u_xlat9;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 0.00100000005);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
    u_xlat9 = max(u_xlat9, 0.319999993);
    u_xlat16_1 = (-_Smoothness) + 1.0;
    u_xlat16_4 = u_xlat16_1 * u_xlat16_1 + 1.5;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat9 = u_xlat9 * u_xlat16_4;
    u_xlat4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_6 = u_xlat16_1 * u_xlat16_1 + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_6 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = u_xlat16_1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_2.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat16_2.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = _Color.xyz * u_xlat16_2.xxx + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xzw;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
float u_xlat9;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 0.00100000005);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
    u_xlat9 = max(u_xlat9, 0.319999993);
    u_xlat16_1 = (-_Smoothness) + 1.0;
    u_xlat16_4 = u_xlat16_1 * u_xlat16_1 + 1.5;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat9 = u_xlat9 * u_xlat16_4;
    u_xlat4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_6 = u_xlat16_1 * u_xlat16_1 + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_6 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = u_xlat16_1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_2.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat16_2.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = _Color.xyz * u_xlat16_2.xxx + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xzw;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform highp sampler2D unity_NHxRoughness;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat1.xyz * (-vec3(u_xlat12)) + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.y = (-_Smoothness) + 1.0;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_3.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat16_14 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_3.xyz = _Color.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.x = vs_TEXCOORD4;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat0.xxx;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
float u_xlat9;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 0.00100000005);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
    u_xlat9 = max(u_xlat9, 0.319999993);
    u_xlat16_1 = (-_Smoothness) + 1.0;
    u_xlat16_4 = u_xlat16_1 * u_xlat16_1 + 1.5;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat9 = u_xlat9 * u_xlat16_4;
    u_xlat4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_6 = u_xlat16_1 * u_xlat16_1 + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_6 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = u_xlat16_1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_2.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat16_2.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = _Color.xyz * u_xlat16_2.xxx + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xzw;
    u_xlat9 = vs_TEXCOORD4;
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
float u_xlat9;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 0.00100000005);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
    u_xlat9 = max(u_xlat9, 0.319999993);
    u_xlat16_1 = (-_Smoothness) + 1.0;
    u_xlat16_4 = u_xlat16_1 * u_xlat16_1 + 1.5;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat9 = u_xlat9 * u_xlat16_4;
    u_xlat4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_6 = u_xlat16_1 * u_xlat16_1 + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_6 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = u_xlat16_1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_2.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat16_2.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = _Color.xyz * u_xlat16_2.xxx + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xzw;
    u_xlat9 = vs_TEXCOORD4;
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform highp sampler2D unity_NHxRoughness;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat1.xyz * (-vec3(u_xlat12)) + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.y = (-_Smoothness) + 1.0;
    u_xlat0.x = texture2D(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_3.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat16_14 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_3.xyz = _Color.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.x = vs_TEXCOORD4;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat0.xxx;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
float u_xlat9;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 0.00100000005);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
    u_xlat9 = max(u_xlat9, 0.319999993);
    u_xlat16_1 = (-_Smoothness) + 1.0;
    u_xlat16_4 = u_xlat16_1 * u_xlat16_1 + 1.5;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat9 = u_xlat9 * u_xlat16_4;
    u_xlat4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_6 = u_xlat16_1 * u_xlat16_1 + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_6 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = u_xlat16_1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_2.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat16_2.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = _Color.xyz * u_xlat16_2.xxx + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xzw;
    u_xlat9 = vs_TEXCOORD4;
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
varying highp vec3 vs_TEXCOORD0;
varying highp float vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
float u_xlat9;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 0.00100000005);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
    u_xlat9 = max(u_xlat9, 0.319999993);
    u_xlat16_1 = (-_Smoothness) + 1.0;
    u_xlat16_4 = u_xlat16_1 * u_xlat16_1 + 1.5;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat9 = u_xlat9 * u_xlat16_4;
    u_xlat4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_6 = u_xlat16_1 * u_xlat16_1 + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_6 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = u_xlat16_1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_2.xyz = _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat16_2.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = _Color.xyz * u_xlat16_2.xxx + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xzw;
    u_xlat9 = vs_TEXCOORD4;
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
}
}
}
Fallback "Booster/Black"
}
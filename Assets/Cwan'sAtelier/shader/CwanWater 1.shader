// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "CwanShader/CwanWater1"
{
	Properties
	{
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 15
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_NoiseIntensity("NoiseIntensity", Range( 0 , 5)) = 0.25
		_Tiling_1("Tiling_1", Float) = 0
		_Scroll_01("Scroll_01", Vector) = (1,1,0,0)
		_Tiling_2("Tiling_2", Float) = 0
		_Scroll_02("Scroll_02", Vector) = (0,0.1,0,0)
		_TextureSample2("Texture Sample 2", 2D) = "bump" {}
		_Normal("Normal", Float) = 0
		_Refraction("Refraction", Range( 0 , 0.1)) = 0
		_CameraSoomth("CameraSoomth", Range( 0 , 0.1)) = 0
		_CameraDepthContrast("CameraDepthContrast", Float) = 0
		_CameraDepthDistance("CameraDepthDistance", Float) = 0
		_EdgeDistance("EdgeDistance", Float) = 2
		_EdgeIntensity("EdgeIntensity", Range( 0 , 1)) = 1
		_convert("convert", Range( 0 , 1)) = 0
		_DepthMetaric("DepthMetaric", Float) = 0
		_DepthColor("DepthColor", Float) = 0.2
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Off
		GrabPass{ }
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityCG.cginc"
		#include "Tessellation.cginc"
		#pragma target 4.6
		#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
		#else
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
		#endif
		#pragma surface surf Standard keepalpha noshadow exclude_path:deferred vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float3 worldPos;
			float4 screenPos;
		};

		uniform sampler2D _TextureSample2;
		uniform float2 _Scroll_01;
		uniform float _Tiling_1;
		uniform float _Normal;
		uniform float2 _Scroll_02;
		uniform float _Tiling_2;
		uniform float _Refraction;
		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabTexture )
		uniform float _DepthColor;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _EdgeDistance;
		uniform float _EdgeIntensity;
		uniform float _NoiseIntensity;
		uniform sampler2D _TextureSample0;
		uniform float _convert;
		uniform float _CameraDepthContrast;
		uniform float _CameraDepthDistance;
		uniform float _CameraSoomth;
		uniform float _DepthMetaric;
		uniform float _EdgeLength;


		inline float4 ASE_ComputeGrabScreenPos( float4 pos )
		{
			#if UNITY_UV_STARTS_AT_TOP
			float scale = -1.0;
			#else
			float scale = 1.0;
			#endif
			float4 o = pos;
			o.y = pos.w * 0.5f;
			o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
			return o;
		}


		float2 voronoihash80( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi80( float2 v, float time, inout float2 id, inout float2 mr, float smoothness, inout float2 smoothId )
		{
			float2 n = floor( v );
			float2 f = frac( v );
			float F1 = 8.0;
			float F2 = 8.0; float2 mg = 0;
			for ( int j = -1; j <= 1; j++ )
			{
				for ( int i = -1; i <= 1; i++ )
			 	{
			 		float2 g = float2( i, j );
			 		float2 o = voronoihash80( n + g );
					o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = f - g - o;
					float d = 0.5 * dot( r, r );
			 		if( d<F1 ) {
			 			F2 = F1;
			 			F1 = d; mg = g; mr = r; id = o;
			 		} else if( d<F2 ) {
			 			F2 = d;
			
			 		}
			 	}
			}
			return F1;
		}


		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
		}

		void vertexDataFunc( inout appdata_full v )
		{
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float2 appendResult120 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 panner33 = ( 1.0 * _Time.y * _Scroll_01 + ( appendResult120 * _Tiling_1 ));
			float2 panner40 = ( 1.0 * _Time.y * _Scroll_02 + ( appendResult120 * _Tiling_2 ));
			float3 temp_output_110_0 = ( ( ( UnpackScaleNormal( tex2D( _TextureSample2, panner33 ), _Normal ) + UnpackScaleNormal( tex2D( _TextureSample2, panner40 ), _Normal ) ) / 2.0 ) * _Refraction );
			o.Normal = ( temp_output_110_0 + 0.001 );
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float4 screenColor104 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,( ase_grabScreenPosNorm + float4( temp_output_110_0 , 0.0 ) ).xy);
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth94 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth94 = saturate( abs( ( screenDepth94 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _EdgeDistance ) ) );
			float temp_output_97_0 = ( 1.0 - distanceDepth94 );
			float time80 = _Time.y;
			float2 voronoiSmoothId80 = 0;
			float2 coords80 = appendResult120 * 1.0;
			float2 id80 = 0;
			float2 uv80 = 0;
			float voroi80 = voronoi80( coords80, time80, id80, uv80, 0, voronoiSmoothId80 );
			float temp_output_142_0 = ( _NoiseIntensity * voroi80 );
			float4 temp_cast_2 = (( ( temp_output_97_0 * _EdgeIntensity ) * temp_output_142_0 )).xxxx;
			float4 lerpResult155 = lerp( ( screenColor104 * _DepthColor ) , temp_cast_2 , temp_output_97_0);
			float4 lerpResult135 = lerp( ( tex2D( _TextureSample0, panner33 ) * temp_output_142_0 ) , ( tex2D( _TextureSample0, panner40 ) * temp_output_142_0 ) , _convert);
			float4 ase_vertex4Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float3 ase_viewPos = UnityObjectToViewPos( ase_vertex4Pos );
			float ase_screenDepth = -ase_viewPos.z;
			float cameraDepthFade8 = (( ase_screenDepth -_ProjectionParams.y - ( 1.0 - _CameraDepthDistance ) ) / _CameraDepthContrast);
			float clampResult129 = clamp( cameraDepthFade8 , 0.2 , 1.0 );
			o.Albedo = saturate( ( lerpResult155 + ( lerpResult135 + ( clampResult129 * screenColor104 ) ) ) ).rgb;
			float temp_output_85_0 = saturate( ( cameraDepthFade8 * _CameraSoomth ) );
			o.Metallic = saturate( ( temp_output_85_0 + _DepthMetaric ) );
			o.Smoothness = temp_output_85_0;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
0;1080;1280;659;1854.023;726.1179;1.925947;True;False
Node;AmplifyShaderEditor.CommentaryNode;172;-3052.99,-1048.847;Inherit;False;1282.48;1016;TriPanar;15;119;124;122;120;41;121;35;123;33;40;82;80;92;43;19;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldPosInputsNode;119;-3002.99,-774.2017;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;120;-2807.844,-744.5136;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;122;-2923.177,-262.847;Inherit;False;Property;_Tiling_2;Tiling_2;9;0;Create;True;0;0;0;False;0;False;0;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;124;-2811.177,-630.847;Inherit;False;Property;_Tiling_1;Tiling_1;7;0;Create;True;0;0;0;False;0;False;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;41;-2651.177,-214.8471;Inherit;False;Property;_Scroll_02;Scroll_02;10;0;Create;True;0;0;0;False;0;False;0,0.1;0.02,0.04;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;123;-2539.177,-742.847;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;121;-2651.177,-326.847;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;35;-2651.177,-470.847;Inherit;False;Property;_Scroll_01;Scroll_01;8;0;Create;True;0;0;0;False;0;False;1,1;-0.01,-0.03;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.CommentaryNode;174;-2210.28,571.9935;Inherit;False;1760.705;488;Normal;10;77;78;75;59;168;79;111;110;166;167;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PannerNode;40;-2379.177,-230.8471;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;168;-2160.28,669.9935;Inherit;False;Property;_Normal;Normal;12;0;Create;True;0;0;0;False;0;False;0;0.4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;33;-2379.177,-486.847;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;75;-1744.28,829.9935;Inherit;True;Property;_TextureSample3;Texture Sample 3;11;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Instance;59;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;59;-1744.28,621.9935;Inherit;True;Property;_TextureSample2;Texture Sample 2;11;0;Create;True;0;0;0;False;0;False;-1;None;918b1c27dd26321459ba1e67a3057bb2;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;175;-1488,-112;Inherit;False;940.2941;467.3047;CameraDepth;6;10;9;169;8;101;16;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;77;-1280.28,637.9935;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;79;-1401.575,838.3237;Inherit;False;Constant;_Float6;Float 6;12;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;171;-1520,-1040;Inherit;False;1109.333;311;EdgeDepth;6;94;95;97;116;100;160;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1424,176;Inherit;False;Property;_CameraDepthDistance;CameraDepthDistance;16;0;Create;True;0;0;0;False;0;False;0;5.03;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;78;-1104.28,637.9935;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;111;-1209.575,838.3237;Inherit;False;Property;_Refraction;Refraction;13;0;Create;True;0;0;0;False;0;False;0;0.1;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;95;-1456,-976;Inherit;False;Property;_EdgeDistance;EdgeDistance;17;0;Create;True;0;0;0;False;0;False;2;1.75;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;82;-2651.177,-902.847;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VoronoiNode;80;-2363.177,-902.847;Inherit;True;0;0;1;0;1;False;1;False;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.RangedFloatNode;92;-2459.177,-998.847;Inherit;False;Property;_NoiseIntensity;NoiseIntensity;6;0;Create;True;0;0;0;False;0;False;0.25;3.25;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;110;-873.5746,630.3237;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GrabScreenPosition;102;-976,384;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DepthFade;94;-1232,-992;Inherit;False;True;True;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;169;-1184,176;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-1440,-64;Inherit;False;Property;_CameraDepthContrast;CameraDepthContrast;15;0;Create;True;0;0;0;False;0;False;0;1.11;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;19;-2091.177,-518.847;Inherit;True;Property;_TextureSample0;Texture Sample 0;5;0;Create;True;0;0;0;False;0;False;-1;3d97a0014f7ffe242bd868b580473156;3d97a0014f7ffe242bd868b580473156;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;142;-1664,-832;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;100;-1056,-880;Inherit;False;Property;_EdgeIntensity;EdgeIntensity;18;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CameraDepthFade;8;-992,32;Inherit;False;3;2;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;103;-685.1017,388.7589;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.OneMinusNode;97;-944,-992;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;43;-2091.177,-262.847;Inherit;True;Property;_TextureSample1;Texture Sample 1;5;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;19;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;136;-1120,-224;Inherit;False;Property;_convert;convert;19;0;Create;True;0;0;0;False;0;False;0;0.406;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;141;-1329.3,-246.9;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ScreenColorNode;104;-544,384;Inherit;False;Global;_GrabScreen0;Grab Screen 0;17;0;Create;True;0;0;0;False;0;False;Object;-1;False;False;False;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;140;-1331.5,-505.5;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;129;-432,-48;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.2;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-1008,240;Inherit;False;Property;_CameraSoomth;CameraSoomth;14;0;Create;True;0;0;0;False;0;False;0;0.1;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;116;-704,-992;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;162;-315.2042,-495.1646;Inherit;False;Property;_DepthColor;DepthColor;21;0;Create;True;0;0;0;False;0;False;0.2;-0.23;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;101;-704,96;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;135;-736,-496;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;160;-560,-864;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;130;-256,-48;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;161;0,-464;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;117;0,-256;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;155;192,-576;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;85;-28.09172,83.13235;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;131;74.81745,189.5275;Inherit;False;Property;_DepthMetaric;DepthMetaric;20;0;Create;True;0;0;0;False;0;False;0;-0.27;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;167;-857.5746,838.3237;Inherit;False;Constant;_Float1;Float 1;16;0;Create;True;0;0;0;False;0;False;0.001;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;132;304,16;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;134;384,-128;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;113;640,-64;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;166;-601.5745,630.3237;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;133;640,16;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;900.5886,-60.65816;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;CwanShader/CwanWater1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Translucent;0.5;True;False;0;False;Opaque;;Transparent;ForwardOnly;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;0.5;False;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;120;0;119;1
WireConnection;120;1;119;3
WireConnection;123;0;120;0
WireConnection;123;1;124;0
WireConnection;121;0;120;0
WireConnection;121;1;122;0
WireConnection;40;0;121;0
WireConnection;40;2;41;0
WireConnection;33;0;123;0
WireConnection;33;2;35;0
WireConnection;75;1;40;0
WireConnection;75;5;168;0
WireConnection;59;1;33;0
WireConnection;59;5;168;0
WireConnection;77;0;59;0
WireConnection;77;1;75;0
WireConnection;78;0;77;0
WireConnection;78;1;79;0
WireConnection;80;0;120;0
WireConnection;80;1;82;2
WireConnection;110;0;78;0
WireConnection;110;1;111;0
WireConnection;94;0;95;0
WireConnection;169;0;10;0
WireConnection;19;1;33;0
WireConnection;142;0;92;0
WireConnection;142;1;80;0
WireConnection;8;0;9;0
WireConnection;8;1;169;0
WireConnection;103;0;102;0
WireConnection;103;1;110;0
WireConnection;97;0;94;0
WireConnection;43;1;40;0
WireConnection;141;0;43;0
WireConnection;141;1;142;0
WireConnection;104;0;103;0
WireConnection;140;0;19;0
WireConnection;140;1;142;0
WireConnection;129;0;8;0
WireConnection;116;0;97;0
WireConnection;116;1;100;0
WireConnection;101;0;8;0
WireConnection;101;1;16;0
WireConnection;135;0;140;0
WireConnection;135;1;141;0
WireConnection;135;2;136;0
WireConnection;160;0;116;0
WireConnection;160;1;142;0
WireConnection;130;0;129;0
WireConnection;130;1;104;0
WireConnection;161;0;104;0
WireConnection;161;1;162;0
WireConnection;117;0;135;0
WireConnection;117;1;130;0
WireConnection;155;0;161;0
WireConnection;155;1;160;0
WireConnection;155;2;97;0
WireConnection;85;0;101;0
WireConnection;132;0;85;0
WireConnection;132;1;131;0
WireConnection;134;0;155;0
WireConnection;134;1;117;0
WireConnection;113;0;134;0
WireConnection;166;0;110;0
WireConnection;166;1;167;0
WireConnection;133;0;132;0
WireConnection;0;0;113;0
WireConnection;0;1;166;0
WireConnection;0;3;133;0
WireConnection;0;4;85;0
ASEEND*/
//CHKSM=FAE40076DFA75A91E23747549D1A1757D913215B
// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "CwanShader/StanderdRGBmask"
{
	Properties
	{
		_Base("Base", 2D) = "white" {}
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_RColor("R:Color", Color) = (0,0,0,0)
		_GColor("G:Color", Color) = (0,0,0,0)
		_BColor("B:Color", Color) = (0,0,0,0)
		_MODS("MODS", 2D) = "white" {}
		_Smooth("Smooth", Range( 0 , 1)) = 0
		_Normal("Normal", 2D) = "bump" {}
		_Float0("Float 0", Float) = 0
		_Float1("Float 1", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform float _Float0;
		uniform sampler2D _Base;
		uniform float4 _Base_ST;
		uniform float4 _RColor;
		uniform sampler2D _TextureSample1;
		uniform float4 _TextureSample1_ST;
		uniform float4 _GColor;
		uniform float4 _BColor;
		uniform sampler2D _MODS;
		uniform float4 _MODS_ST;
		uniform float _Float1;
		uniform float _Smooth;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			o.Normal = UnpackScaleNormal( tex2D( _Normal, uv_Normal ), _Float0 );
			float2 uv_Base = i.uv_texcoord * _Base_ST.xy + _Base_ST.zw;
			float2 uv_TextureSample1 = i.uv_texcoord * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			float4 break20 = tex2D( _TextureSample1, uv_TextureSample1 );
			o.Albedo = ( tex2D( _Base, uv_Base ) + ( ( _RColor * break20.r ) + ( _GColor * break20.g ) + ( _BColor * break20.b ) ) ).rgb;
			float2 uv_MODS = i.uv_texcoord * _MODS_ST.xy + _MODS_ST.zw;
			float4 tex2DNode10 = tex2D( _MODS, uv_MODS );
			o.Metallic = ( tex2DNode10.r * _Float1 );
			o.Smoothness = ( tex2DNode10.a * _Smooth );
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
0;12;1920;1007;1768.884;617.2239;1.410177;True;True
Node;AmplifyShaderEditor.SamplerNode;2;-1878.682,-172.1689;Inherit;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;0;False;0;False;-1;None;c22d25d1cc4c82c448e37402a57fee6a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;8;-893.4875,-631.8437;Inherit;False;Property;_BColor;B:Color;4;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.9465629,1,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;4;-1536,-640;Inherit;False;Property;_RColor;R:Color;2;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;20;-1568,-176;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ColorNode;7;-1216,-640;Inherit;False;Property;_GColor;G:Color;3;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,0.2579771,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-961.8814,-256;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-704,-144;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-1312,-432;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;10;-868.0078,67.36603;Inherit;True;Property;_MODS;MODS;5;0;Create;True;0;0;0;False;0;False;-1;None;dd8c69280e5bd4f4687488126ce565dc;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;23;-298.291,-185.9152;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-374.1943,-40.68182;Inherit;False;Property;_Float1;Float 1;10;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-581.0078,241.366;Inherit;False;Property;_Smooth;Smooth;6;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-449.9733,-432.1895;Inherit;True;Property;_Base;Base;0;0;Create;True;0;0;0;False;0;False;-1;None;96adcfc2b126ebe47a40ba6a46ca99a6;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;24;-740.2194,419.2552;Inherit;True;Property;_Float0;Float 0;9;0;Create;True;0;0;0;False;0;False;0;-0.65;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-435.0078,112.366;Inherit;False;Property;_AO;AO;7;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-240,96;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-143.1943,-25.68182;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;5;-141,-216;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-240,192;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;18;-448.5519,365.1286;Inherit;True;Property;_Normal;Normal;8;0;Create;True;0;0;0;False;0;False;-1;None;eea9347eb5ec4e647a60f08fd234bcfc;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;221.0036,-88.82735;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;CwanShader/StanderdRGBmask;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;20;0;2;0
WireConnection;6;0;7;0
WireConnection;6;1;20;1
WireConnection;9;0;8;0
WireConnection;9;1;20;2
WireConnection;3;0;4;0
WireConnection;3;1;20;0
WireConnection;23;0;3;0
WireConnection;23;1;6;0
WireConnection;23;2;9;0
WireConnection;12;0;10;2
WireConnection;12;1;13;0
WireConnection;25;0;10;1
WireConnection;25;1;26;0
WireConnection;5;0;1;0
WireConnection;5;1;23;0
WireConnection;16;0;10;4
WireConnection;16;1;17;0
WireConnection;18;5;24;0
WireConnection;0;0;5;0
WireConnection;0;1;18;0
WireConnection;0;3;25;0
WireConnection;0;4;16;0
ASEEND*/
//CHKSM=87CE7B760E55FA12B8AE5236D73576435799397D
// Upgrade NOTE: replaced tex2D unity_Lightmap with UNITY_SAMPLE_TEX2D

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "CwanShader/LightmapMix"
{
	Properties
	{
		_Float0("Float 0", Range( 0 , 1)) = 0
		_Float1("Float 1", Range( 0 , 1)) = 0
		_Float2("Float 2", Range( 0 , 1)) = 0
		_SmoothAO("SmoothAO", Range( 0 , 1)) = 1
		_Color0("Color 0", Color) = (0,0,0,0)
		_Float3("Float 3", Float) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 vertexToFrag10_g2;
			float2 vertexToFrag10_g6;
		};

		uniform float4 _Color0;
		uniform float _Float0;
		uniform float _Float1;
		uniform float _Float2;
		uniform float _Float3;
		uniform float _SmoothAO;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.vertexToFrag10_g2 = ( ( v.texcoord1.xy * (unity_LightmapST).xy ) + (unity_LightmapST).zw );
			o.vertexToFrag10_g6 = ( ( v.texcoord1.xy * (unity_LightmapST).xy ) + (unity_LightmapST).zw );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Albedo = _Color0.rgb;
			float4 tex2DNode7_g2 = UNITY_SAMPLE_TEX2D( unity_Lightmap, i.vertexToFrag10_g2 );
			float3 decodeLightMap6_g2 = DecodeLightmap(tex2DNode7_g2);
			float3 break5 = decodeLightMap6_g2;
			float4 appendResult8 = (float4(( break5.x * _Float0 ) , ( break5.y * _Float1 ) , ( break5.z * _Float2 ) , 0.0));
			o.Emission = ( appendResult8 * _Float3 ).rgb;
			float4 tex2DNode7_g6 = UNITY_SAMPLE_TEX2D( unity_Lightmap, i.vertexToFrag10_g6 );
			float3 decodeLightMap6_g6 = DecodeLightmap(tex2DNode7_g6);
			float3 temp_output_25_0 = decodeLightMap6_g6;
			o.Smoothness = ( temp_output_25_0 + _SmoothAO ).x;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
0;1080;1280;659;1430.599;304.1624;1.630188;True;True
Node;AmplifyShaderEditor.FunctionNode;3;-1088,-96;Inherit;False;FetchLightmapValue;0;;2;43de3d4ae59f645418fdd020d1b8e78e;0;0;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1188,-370;Inherit;False;Property;_Float0;Float 0;2;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-1184,-208;Inherit;False;Property;_Float1;Float 1;3;0;Create;True;0;0;0;False;0;False;0;0.686;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-1168,112;Inherit;False;Property;_Float2;Float 2;4;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;5;-855,-96;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-587.5182,-259.4027;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-566.5182,-125.4027;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-569.5182,-32.40271;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-254.141,79.842;Inherit;False;Property;_Float3;Float 3;7;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;8;-336,-96;Inherit;False;COLOR;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;25;-707.1995,382.2158;Inherit;False;FetchLightmapValue;0;;6;43de3d4ae59f645418fdd020d1b8e78e;0;0;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-686.2258,552.0261;Inherit;False;Property;_SmoothAO;SmoothAO;5;0;Create;True;0;0;0;False;0;False;1;0.521;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;19;-840.2,109.4;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-317.1806,491.3693;Inherit;False;Constant;_Float4;Float 4;8;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-109.1777,-28.44389;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;31;-183.4921,-280.6146;Inherit;False;Property;_Color0;Color 0;6;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.5566037,0.5566037,0.5566037,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;17;-864,-208;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;15;-868,-370;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-453.3823,384.2499;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;5;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;34;-173.724,325.0901;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;66,-8;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;CwanShader/LightmapMix;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;5;0;3;0
WireConnection;9;0;5;0
WireConnection;9;1;10;0
WireConnection;11;0;5;1
WireConnection;11;1;16;0
WireConnection;13;0;5;2
WireConnection;13;1;18;0
WireConnection;8;0;9;0
WireConnection;8;1;11;0
WireConnection;8;2;13;0
WireConnection;19;0;18;0
WireConnection;32;0;8;0
WireConnection;32;1;33;0
WireConnection;17;0;16;0
WireConnection;15;0;10;0
WireConnection;27;0;25;0
WireConnection;27;1;24;0
WireConnection;34;0;25;0
WireConnection;34;1;24;0
WireConnection;0;0;31;0
WireConnection;0;2;32;0
WireConnection;0;4;34;0
ASEEND*/
//CHKSM=B82448918B26F495312976AAD56CC4096A5483B8
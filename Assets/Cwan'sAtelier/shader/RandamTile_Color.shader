// Upgrade NOTE: replaced tex2D unity_Lightmap with UNITY_SAMPLE_TEX2D

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "CwanShader/RandamTileColor"
{
	Properties
	{
		[Color]_seed("seed", Float) = 1
		_Float0("Tilling", Float) = 2
		_TileTexture("TileTexture", 2D) = "white" {}
		_Normal("Normal", 2D) = "white" {}
		_SmoothnessTexture("SmoothnessTexture", 2D) = "white" {}
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		_SmoothAO("SmoothAO", Range( 0 , 10)) = 1
		_Hue("Hue", Range( 0 , 1)) = 0
		_HueWidth("HueWidth", Range( -1 , 1)) = 0.8507008
		_Saturation("Saturation", Range( 0 , 1)) = 1
		_Brightness("Brightness", Range( 0 , 1)) = 1
		_MultiBase("MultiBase", Range( 0 , 1)) = 0.5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "ColorControle"="1" }
		Cull Back
		CGPROGRAM
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
			float2 vertexToFrag10_g6;
		};

		uniform sampler2D _Normal;
		uniform float _Float0;
		uniform sampler2D _TileTexture;
		uniform float _MultiBase;
		uniform float _Hue;
		uniform float _HueWidth;
		uniform float _seed;
		uniform float _Saturation;
		uniform float _Brightness;
		uniform sampler2D _SmoothnessTexture;
		uniform float4 _SmoothnessTexture_ST;
		uniform float _Smoothness;
		uniform float _SmoothAO;


		float3 HSVToRGB( float3 c )
		{
			float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
			float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
			return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.vertexToFrag10_g6 = ( ( v.texcoord1.xy * (unity_LightmapST).xy ) + (unity_LightmapST).zw );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_cast_0 = (_Float0).xx;
			float2 uv_TexCoord130 = i.uv_texcoord * temp_cast_0;
			o.Normal = tex2D( _Normal, uv_TexCoord130 ).rgb;
			float4 tex2DNode123 = tex2D( _TileTexture, uv_TexCoord130 );
			float4 lerpResult129 = lerp( tex2DNode123 , ( 1.0 - tex2DNode123 ) , _MultiBase);
			float2 temp_cast_2 = (( _Float0 * 4.0 )).xx;
			float2 uv_TexCoord2 = i.uv_texcoord * temp_cast_2;
			float dotResult4_g1 = dot( ( _seed + floor( uv_TexCoord2 ) ) , float2( 12.9898,78.233 ) );
			float lerpResult10_g1 = lerp( _HueWidth , 1.0 , frac( ( sin( dotResult4_g1 ) * 43758.55 ) ));
			float3 hsvTorgb201 = HSVToRGB( float3(( _Hue + ( lerpResult10_g1 - _HueWidth ) ),_Saturation,_Brightness) );
			o.Albedo = ( lerpResult129 + ( tex2DNode123 * ( tex2DNode123 * float4( hsvTorgb201 , 0.0 ) ) ) ).rgb;
			float2 uv_SmoothnessTexture = i.uv_texcoord * _SmoothnessTexture_ST.xy + _SmoothnessTexture_ST.zw;
			float4 lerpResult166 = lerp( tex2D( _SmoothnessTexture, uv_SmoothnessTexture ) , float4( 1,1,1,0 ) , _Smoothness);
			float4 tex2DNode7_g6 = UNITY_SAMPLE_TEX2D( unity_Lightmap, i.vertexToFrag10_g6 );
			float3 decodeLightMap6_g6 = DecodeLightmap(tex2DNode7_g6);
			o.Smoothness = ( lerpResult166 * float4( saturate( ( decodeLightMap6_g6 * _SmoothAO ) ) , 0.0 ) ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
0;0;1920;1019;2539.766;1574.406;2.532283;True;True
Node;AmplifyShaderEditor.RangedFloatNode;3;-1648,-896;Inherit;False;Property;_Float0;Tilling;3;0;Create;False;0;0;0;False;0;False;2;7.26;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;132;-1648,-768;Inherit;False;Constant;_Float1;Float 1;7;0;Create;True;0;0;0;False;0;False;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;131;-1504,-784;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1328,-544;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FloorOpNode;4;-1104,-544;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;220;-1104,-704;Inherit;False;Property;_seed;seed;2;0;Create;True;0;0;0;False;1;Color;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;219;-944,-576;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;210;-1120,-384;Inherit;False;Property;_HueWidth;HueWidth;10;0;Create;True;0;0;0;False;0;False;0.8507008;0.81;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;5;-752,-576;Inherit;True;Random Range;-1;;1;7b754edb8aebbfb4a9ace907af661cfc;0;3;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;218;-476.4118,-498.049;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;215;-656,-704;Inherit;False;Property;_Hue;Hue;9;0;Create;False;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;130;-752,-912;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;202;-512,-368;Inherit;False;Property;_Saturation;Saturation;11;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;203;-512,-272;Inherit;False;Property;_Brightness;Brightness;12;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;214;-336,-512;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.HSVToRGBNode;201;-176,-512;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;184;256,192;Inherit;False;Property;_SmoothAO;SmoothAO;8;0;Create;True;0;0;0;False;0;False;1;2.07;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;123;-192,-928;Inherit;True;Property;_TileTexture;TileTexture;4;0;Create;True;0;0;0;False;0;False;-1;8c5ffde5bb069c143933d758e34ef1f2;8c5ffde5bb069c143933d758e34ef1f2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;168;176,112;Inherit;False;FetchLightmapValue;0;;6;43de3d4ae59f645418fdd020d1b8e78e;0;0;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;127;192,-736;Inherit;False;Property;_MultiBase;MultiBase;13;0;Create;True;0;0;0;False;0;False;0.5;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;125;304,-528;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;116;288,32;Inherit;False;Property;_Smoothness;Smoothness;7;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;182;416,128;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;5;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;165;304,-176;Inherit;True;Property;_SmoothnessTexture;SmoothnessTexture;6;0;Create;True;0;0;0;False;0;False;-1;None;e272d142588b4604da3e4385acb66e7f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;187;256,-832;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;129;496,-928;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;189;512,-544;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;183;592,32;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;166;624,-176;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;1,1,1,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;190;864,-736;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;170;784,-176;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;100;304,-384;Inherit;True;Property;_Normal;Normal;5;0;Create;True;0;0;0;False;0;False;-1;None;2649feb89e3ba0e40847cc87b510f34a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1088,-400;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;CwanShader/RandamTileColor;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;1;ColorControle=1;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;131;0;3;0
WireConnection;131;1;132;0
WireConnection;2;0;131;0
WireConnection;4;0;2;0
WireConnection;219;0;220;0
WireConnection;219;1;4;0
WireConnection;5;1;219;0
WireConnection;5;2;210;0
WireConnection;218;0;5;0
WireConnection;218;1;210;0
WireConnection;130;0;3;0
WireConnection;214;0;215;0
WireConnection;214;1;218;0
WireConnection;201;0;214;0
WireConnection;201;1;202;0
WireConnection;201;2;203;0
WireConnection;123;1;130;0
WireConnection;125;0;123;0
WireConnection;125;1;201;0
WireConnection;182;0;168;0
WireConnection;182;1;184;0
WireConnection;187;0;123;0
WireConnection;129;0;123;0
WireConnection;129;1;187;0
WireConnection;129;2;127;0
WireConnection;189;0;123;0
WireConnection;189;1;125;0
WireConnection;183;0;182;0
WireConnection;166;0;165;0
WireConnection;166;2;116;0
WireConnection;190;0;129;0
WireConnection;190;1;189;0
WireConnection;170;0;166;0
WireConnection;170;1;183;0
WireConnection;100;1;130;0
WireConnection;0;0;190;0
WireConnection;0;1;100;0
WireConnection;0;4;170;0
ASEEND*/
//CHKSM=20EC0B446856490CC0AD84912B360B73D7F1F4DD
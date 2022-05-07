// Upgrade NOTE: replaced tex2D unity_Lightmap with UNITY_SAMPLE_TEX2D

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "CwanShader/RandamTile"
{
	Properties
	{
		_TileTexture("TileTexture", 2D) = "white" {}
		_Normal("Normal", 2D) = "white" {}
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		_SmoothAO("SmoothAO", Range( 0 , 10)) = 1
		_Seed("Seed", Float) = 5
		_Float0("Tilling", Float) = 1
		_MultiBase("MultiBase", Range( 0 , 1)) = 0.5
		_CustomTexture("CustomTexture", 2D) = "white" {}
		_HueWidth("HueWidth", Range( 0 , 1)) = 0
		_Float3("Float 3", Range( 0 , 1)) = 0
		_Float2("Float 2", Range( 0 , 1)) = 0
		_Float4("Float 4", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
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
		uniform sampler2D _CustomTexture;
		uniform float4 _CustomTexture_ST;
		uniform float _HueWidth;
		uniform float _Seed;
		uniform float _Float4;
		uniform float _Float2;
		uniform float _Float3;
		uniform sampler2D _TextureSample1;
		uniform float4 _TextureSample1_ST;
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
			float2 uv_CustomTexture = i.uv_texcoord * _CustomTexture_ST.xy + _CustomTexture_ST.zw;
			float2 temp_cast_2 = (( _Float0 * 4.0 )).xx;
			float2 uv_TexCoord2 = i.uv_texcoord * temp_cast_2;
			float dotResult4_g1 = dot( ( floor( uv_TexCoord2 ) + _Seed ) , float2( 12.9898,78.233 ) );
			float lerpResult10_g1 = lerp( _HueWidth , 1.0 , frac( ( sin( dotResult4_g1 ) * 43758.55 ) ));
			float temp_output_5_0 = lerpResult10_g1;
			float3 hsvTorgb202 = HSVToRGB( float3(( _Float4 + ( temp_output_5_0 - _HueWidth ) ),_Float2,_Float3) );
			o.Albedo = ( lerpResult129 + ( tex2DNode123 * ( ( tex2D( _CustomTexture, uv_CustomTexture ) * temp_output_5_0 ) * float4( hsvTorgb202 , 0.0 ) ) ) ).rgb;
			float2 uv_TextureSample1 = i.uv_texcoord * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			float4 lerpResult166 = lerp( tex2D( _TextureSample1, uv_TextureSample1 ) , float4( 1,1,1,0 ) , _Smoothness);
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
0;-894;1600;833;-797.5737;793.3169;1;True;True
Node;AmplifyShaderEditor.RangedFloatNode;132;-1280,-640;Inherit;False;Constant;_Float1;Float 1;7;0;Create;True;0;0;0;False;0;False;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-1280,-736;Inherit;False;Property;_Float0;Tilling;8;0;Create;False;0;0;0;False;0;False;1;8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;131;-1115.805,-654.8529;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-960,-224;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FloorOpNode;4;-720,-224;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;52;-736,-144;Float;False;Property;_Seed;Seed;7;0;Create;True;0;0;0;False;0;False;5;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;201;-576,-224;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;200;-864,0;Inherit;False;Property;_HueWidth;HueWidth;11;0;Create;True;0;0;0;False;0;False;0;0.82;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;5;-448,-224;Inherit;True;Random Range;-1;;1;7b754edb8aebbfb4a9ace907af661cfc;0;3;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;207;-160,-112;Inherit;False;Property;_Float4;Float 4;14;0;Create;True;0;0;0;False;0;False;0;0.199;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;205;-160,-16;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;136;-160,-480;Inherit;True;Property;_CustomTexture;CustomTexture;10;0;Create;True;0;0;0;False;0;False;-1;18f0cadbedd1b0843bbe9fbaee69f854;18f0cadbedd1b0843bbe9fbaee69f854;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;203;-160,208;Inherit;False;Property;_Float2;Float 2;13;0;Create;True;0;0;0;False;0;False;0;0.098;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;204;-160,288;Inherit;False;Property;_Float3;Float 3;12;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;206;128,-96;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;130;-960,-880;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.HSVToRGBNode;202;304,-96;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;184;640,128;Inherit;False;Property;_SmoothAO;SmoothAO;6;0;Create;True;0;0;0;False;0;False;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;272,-352;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;123;-160,-896;Inherit;True;Property;_TileTexture;TileTexture;2;0;Create;True;0;0;0;False;0;False;-1;8c5ffde5bb069c143933d758e34ef1f2;8c5ffde5bb069c143933d758e34ef1f2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;168;640,16;Inherit;False;FetchLightmapValue;0;;6;43de3d4ae59f645418fdd020d1b8e78e;0;0;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;127;336,-704;Inherit;False;Property;_MultiBase;MultiBase;9;0;Create;True;0;0;0;False;0;False;0.5;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;209;544,-352;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;182;928,16;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;5;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;187;448,-784;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;116;784,-64;Inherit;False;Property;_Smoothness;Smoothness;5;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;165;768,-272;Inherit;True;Property;_TextureSample1;Texture Sample 1;4;0;Create;True;0;0;0;False;0;False;-1;None;e272d142588b4604da3e4385acb66e7f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;183;1104,-64;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;129;736,-880;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;125;736,-592;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;166;1104,-272;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;1,1,1,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;100;1056,-496;Inherit;True;Property;_Normal;Normal;3;0;Create;True;0;0;0;False;0;False;-1;None;2649feb89e3ba0e40847cc87b510f34a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;190;1008,-880;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;170;1264,-272;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1648,-512;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;CwanShader/RandamTile;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;131;0;3;0
WireConnection;131;1;132;0
WireConnection;2;0;131;0
WireConnection;4;0;2;0
WireConnection;201;0;4;0
WireConnection;201;1;52;0
WireConnection;5;1;201;0
WireConnection;5;2;200;0
WireConnection;205;0;5;0
WireConnection;205;1;200;0
WireConnection;206;0;207;0
WireConnection;206;1;205;0
WireConnection;130;0;3;0
WireConnection;202;0;206;0
WireConnection;202;1;203;0
WireConnection;202;2;204;0
WireConnection;66;0;136;0
WireConnection;66;1;5;0
WireConnection;123;1;130;0
WireConnection;209;0;66;0
WireConnection;209;1;202;0
WireConnection;182;0;168;0
WireConnection;182;1;184;0
WireConnection;187;0;123;0
WireConnection;183;0;182;0
WireConnection;129;0;123;0
WireConnection;129;1;187;0
WireConnection;129;2;127;0
WireConnection;125;0;123;0
WireConnection;125;1;209;0
WireConnection;166;0;165;0
WireConnection;166;2;116;0
WireConnection;100;1;130;0
WireConnection;190;0;129;0
WireConnection;190;1;125;0
WireConnection;170;0;166;0
WireConnection;170;1;183;0
WireConnection;0;0;190;0
WireConnection;0;1;100;0
WireConnection;0;4;170;0
ASEEND*/
//CHKSM=788C31CFD5EFD30DA08C85605B17B51BF3401BF1
// Upgrade NOTE: replaced tex2D unity_Lightmap with UNITY_SAMPLE_TEX2D

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "CwanShader/Flag"
{
	Properties
	{
		_moveblend("moveblend", Range( 0 , 1)) = 0.3
		_intensity("intensity", Range( -1 , 1)) = 0.1
		_position("position", Float) = 1.72
		_bityosei("bityosei", Float) = 0
		_Float2("Float 2", Float) = 0
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float2 vertexToFrag10_g3;
		};

		uniform float _position;
		uniform float _intensity;
		uniform float _moveblend;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform float _bityosei;
		uniform float _Float2;
		uniform sampler2D _TextureSample1;
		uniform float4 _TextureSample1_ST;


		float2 voronoihash9( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi9( float2 v, float time, inout float2 id, inout float2 mr, float smoothness, inout float2 smoothId )
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
			 		float2 o = voronoihash9( n + g );
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


		float2 voronoihash34( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi34( float2 v, float time, inout float2 id, inout float2 mr, float smoothness, inout float2 smoothId )
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
			 		float2 o = voronoihash34( n + g );
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


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float temp_output_14_0 = ( ase_vertex3Pos.y + _position );
			float temp_output_23_0 = ( ( 1.0 - temp_output_14_0 ) * 0.4 );
			float time9 = _Time.y;
			float2 voronoiSmoothId9 = 0;
			float lerpResult12 = lerp( ase_vertex3Pos.x , ase_vertex3Pos.y , 0.16);
			float2 temp_cast_0 = (lerpResult12).xx;
			float2 coords9 = temp_cast_0 * 0.63;
			float2 id9 = 0;
			float2 uv9 = 0;
			float voroi9 = voronoi9( coords9, time9, id9, uv9, 0, voronoiSmoothId9 );
			float time34 = _Time.y;
			float2 voronoiSmoothId34 = 0;
			float lerpResult49 = lerp( ase_vertex3Pos.x , ase_vertex3Pos.y , 0.0);
			float2 temp_cast_1 = (lerpResult49).xx;
			float2 coords34 = temp_cast_1 * 1.0;
			float2 id34 = 0;
			float2 uv34 = 0;
			float voroi34 = voronoi34( coords34, time34, id34, uv34, 0, voronoiSmoothId34 );
			float lerpResult37 = lerp( ( ( temp_output_23_0 * voroi9 ) * _intensity ) , ( ( ( ( 1.0 - ( ase_vertex3Pos.y + 0.47 ) ) * 0.4 ) * voroi34 ) * _intensity ) , _moveblend);
			float3 temp_cast_2 = (lerpResult37).xxx;
			v.vertex.xyz += temp_cast_2;
			v.vertex.w = 1;
			o.vertexToFrag10_g3 = ( ( v.texcoord1.xy * (unity_LightmapST).xy ) + (unity_LightmapST).zw );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float temp_output_14_0 = ( ase_vertex3Pos.y + _position );
			float temp_output_23_0 = ( ( 1.0 - temp_output_14_0 ) * 0.4 );
			float time9 = _Time.y;
			float2 voronoiSmoothId9 = 0;
			float lerpResult12 = lerp( ase_vertex3Pos.x , ase_vertex3Pos.y , 0.16);
			float2 temp_cast_0 = (lerpResult12).xx;
			float2 coords9 = temp_cast_0 * 0.63;
			float2 id9 = 0;
			float2 uv9 = 0;
			float voroi9 = voronoi9( coords9, time9, id9, uv9, 0, voronoiSmoothId9 );
			float time34 = _Time.y;
			float2 voronoiSmoothId34 = 0;
			float lerpResult49 = lerp( ase_vertex3Pos.x , ase_vertex3Pos.y , 0.0);
			float2 temp_cast_1 = (lerpResult49).xx;
			float2 coords34 = temp_cast_1 * 1.0;
			float2 id34 = 0;
			float2 uv34 = 0;
			float voroi34 = voronoi34( coords34, time34, id34, uv34, 0, voronoiSmoothId34 );
			float lerpResult37 = lerp( ( ( temp_output_23_0 * voroi9 ) * _intensity ) , ( ( ( ( 1.0 - ( ase_vertex3Pos.y + 0.47 ) ) * 0.4 ) * voroi34 ) * _intensity ) , _moveblend);
			float temp_output_58_0 = ( ( lerpResult37 + _bityosei ) * _Float2 );
			float4 tex2DNode7_g3 = UNITY_SAMPLE_TEX2D( unity_Lightmap, i.vertexToFrag10_g3 );
			float3 decodeLightMap6_g3 = DecodeLightmap(tex2DNode7_g3);
			o.Emission = ( ( tex2D( _TextureSample0, uv_TextureSample0 ) * temp_output_58_0 ) * float4( decodeLightMap6_g3 , 0.0 ) ).rgb;
			float2 uv_TextureSample1 = i.uv_texcoord * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			o.Smoothness = ( temp_output_58_0 * tex2D( _TextureSample1, uv_TextureSample1 ) ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
0;-900;1600;839;1901.144;593.6269;1.9;True;True
Node;AmplifyShaderEditor.PosVertexDataNode;2;-1657.978,193.0517;Inherit;True;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;31;-1280,560;Inherit;False;Constant;_Float3;Float 3;1;0;Create;True;0;0;0;False;0;False;0.47;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-1280,0;Inherit;False;Property;_position;position;5;0;Create;True;0;0;0;False;0;False;1.72;0.76;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-1264,720;Inherit;False;Constant;_Float1;Float 1;1;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1280,224;Inherit;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;0;False;0;False;0.16;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;29;-1088,368;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;14;-1088,-176;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;10;-1408,352;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;18;-928,-176;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;12;-1104,112;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;30;-928,368;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;49;-1104,592;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;79;-1091.932,5.779916;Inherit;False;Constant;_Float4;Float 4;10;0;Create;True;0;0;0;False;0;False;0.4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VoronoiNode;34;-736,592;Inherit;True;0;0;1;0;1;False;1;False;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-736,368;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-736,-176;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VoronoiNode;9;-736,96;Inherit;True;0;0;1;0;1;False;1;False;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0.63;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;80;-400,-176;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-352,80;Inherit;False;Property;_intensity;intensity;4;0;Create;True;0;0;0;False;0;False;0.1;-0.29;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-336,368;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-378,212;Inherit;False;Property;_moveblend;moveblend;3;0;Create;True;0;0;0;False;0;False;0.3;0.33;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-173.2494,-168.6295;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;-129.2605,288.861;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;158.6787,145.4434;Inherit;False;Property;_bityosei;bityosei;6;0;Create;True;0;0;0;False;0;False;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;37;52.79652,7.873249;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;57;368,-64;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;59;161.3,224;Inherit;False;Property;_Float2;Float 2;7;0;Create;True;0;0;0;False;0;False;0;11.46;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;58;534.601,-66.67358;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;70;255.3981,-368.0596;Inherit;True;Property;_TextureSample0;Texture Sample 0;9;0;Create;True;0;0;0;False;0;False;-1;None;18f0cadbedd1b0843bbe9fbaee69f854;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;72;334.3981,248.9404;Inherit;True;Property;_TextureSample1;Texture Sample 1;8;0;Create;True;0;0;0;False;0;False;-1;None;e272d142588b4604da3e4385acb66e7f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;87;723.447,308.2789;Inherit;False;FetchLightmapValue;1;;3;43de3d4ae59f645418fdd020d1b8e78e;0;0;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;755.3981,-151.0596;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;86;-1095.112,-375.2611;Inherit;False;Constant;_Float5;Float 5;8;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;-489.5957,-455.2034;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;82;-843.1957,-398.0032;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;764.3981,-4.059631;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;88;1043.247,-114.2211;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1248.146,-143.7041;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;CwanShader/Flag;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Transparent;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;29;0;2;2
WireConnection;29;1;31;0
WireConnection;14;0;2;2
WireConnection;14;1;15;0
WireConnection;18;0;14;0
WireConnection;12;0;2;1
WireConnection;12;1;2;2
WireConnection;12;2;13;0
WireConnection;30;0;29;0
WireConnection;49;0;2;1
WireConnection;49;1;2;2
WireConnection;49;2;50;0
WireConnection;34;0;49;0
WireConnection;34;1;10;2
WireConnection;32;0;30;0
WireConnection;32;1;79;0
WireConnection;23;0;18;0
WireConnection;23;1;79;0
WireConnection;9;0;12;0
WireConnection;9;1;10;2
WireConnection;80;0;23;0
WireConnection;80;1;9;0
WireConnection;35;0;32;0
WireConnection;35;1;34;0
WireConnection;27;0;80;0
WireConnection;27;1;28;0
WireConnection;74;0;35;0
WireConnection;74;1;28;0
WireConnection;37;0;27;0
WireConnection;37;1;74;0
WireConnection;37;2;38;0
WireConnection;57;0;37;0
WireConnection;57;1;56;0
WireConnection;58;0;57;0
WireConnection;58;1;59;0
WireConnection;71;0;70;0
WireConnection;71;1;58;0
WireConnection;84;0;82;0
WireConnection;84;1;23;0
WireConnection;82;0;14;0
WireConnection;82;1;86;0
WireConnection;73;0;58;0
WireConnection;73;1;72;0
WireConnection;88;0;71;0
WireConnection;88;1;87;0
WireConnection;0;2;88;0
WireConnection;0;4;73;0
WireConnection;0;11;37;0
ASEEND*/
//CHKSM=72C9DDF71808D707E01B129D17111D97D657FF9C
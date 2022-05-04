// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "CwanShader/Flag"
{
	Properties
	{
		_moveblend("moveblend", Range( 0 , 1)) = 0.3
		_intensity("intensity", Float) = 0.1
		_move2("move2", Float) = 0.4
		_position("position", Float) = 1.72
		_Color1("Color 1", Color) = (0,0,0,0)
		_bityosei("bityosei", Float) = 0
		_Float2("Float 2", Float) = 0
		_Float4("Float 4", Range( 0 , 1)) = 1
		_Float5("Float 5", Float) = -0.2
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
		};

		uniform float _position;
		uniform float _Float5;
		uniform float _intensity;
		uniform float _move2;
		uniform float _moveblend;
		uniform float4 _Color1;
		uniform float _bityosei;
		uniform float _Float2;
		uniform float _Float4;


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
			float lerpResult37 = lerp( ( ( ( 1.0 - ( ase_vertex3Pos.y + _position ) ) * ( voroi9 + _Float5 ) ) * _intensity ) , ( ( ( 1.0 - ( ase_vertex3Pos.y + 0.47 ) ) * _move2 ) * voroi34 ) , _moveblend);
			float3 temp_cast_2 = (lerpResult37).xxx;
			v.vertex.xyz += temp_cast_2;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
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
			float lerpResult37 = lerp( ( ( ( 1.0 - ( ase_vertex3Pos.y + _position ) ) * ( voroi9 + _Float5 ) ) * _intensity ) , ( ( ( 1.0 - ( ase_vertex3Pos.y + 0.47 ) ) * _move2 ) * voroi34 ) , _moveblend);
			float temp_output_58_0 = ( ( lerpResult37 + _bityosei ) * _Float2 );
			float4 temp_cast_2 = (temp_output_58_0).xxxx;
			float4 lerpResult61 = lerp( _Color1 , temp_cast_2 , _Float4);
			o.Albedo = lerpResult61.rgb;
			o.Smoothness = temp_output_58_0;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
679;0;1240;1019;1067.326;281.7166;1;True;True
Node;AmplifyShaderEditor.RangedFloatNode;13;-1049,393.5;Inherit;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;0;False;0;False;0.16;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;2;-1266.921,187.3345;Inherit;True;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;31;-1061.469,704.0436;Inherit;False;Constant;_Float3;Float 3;1;0;Create;True;0;0;0;False;0;False;0.47;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-961.2264,18.14934;Inherit;False;Property;_position;position;7;0;Create;True;0;0;0;False;0;False;1.72;1.72;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;10;-1179,-1.5;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;12;-841,159.5;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VoronoiNode;9;-520,108.5;Inherit;True;0;0;1;0;1;False;1;False;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0.63;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.SimpleAddOpNode;29;-891.2693,468.2436;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;68;-504.3262,22.28336;Inherit;False;Property;_Float5;Float 5;13;0;Create;True;0;0;0;False;0;False;-0.2;-0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-1015.552,1017.802;Inherit;False;Constant;_Float1;Float 1;1;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;14;-791.0267,-217.6507;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;18;-553.5266,-228.0507;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;67;-311.3262,-0.7166443;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-586.2567,692.1385;Inherit;False;Property;_move2;move2;6;0;Create;True;0;0;0;False;0;False;0.4;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;49;-807.5516,783.8023;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;30;-625.4343,449.343;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-377.108,428.7868;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VoronoiNode;34;-428.2925,708.7939;Inherit;True;0;0;1;0;1;False;1;False;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-275.4098,-160.5419;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-271.8665,154.8155;Inherit;False;Property;_intensity;intensity;5;0;Create;True;0;0;0;False;0;False;0.1;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-1.622437,196.7716;Inherit;False;Property;_moveblend;moveblend;4;0;Create;True;0;0;0;False;0;False;0.3;0.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-77.09194,-44.69163;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-142.8895,485.9082;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;296.9565,188.176;Inherit;False;Property;_bityosei;bityosei;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;37;183.4106,-23.69187;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;57;369.7565,-30.02395;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;59;297.3176,278.1834;Inherit;False;Property;_Float2;Float 2;11;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;52;568.6537,-663.4923;Inherit;False;Property;_Color1;Color 1;8;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;58;538.3176,-25.81656;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;363.3935,-388.5653;Inherit;False;Property;_Float4;Float 4;12;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;61;692.2937,-414.5655;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;54;343.8508,-265.1933;Inherit;False;NormalCreate;2;;2;e12f7ae19d416b942820e3932b56220f;0;4;1;SAMPLER2D;;False;2;FLOAT2;0,0;False;3;FLOAT;0.5;False;4;FLOAT;2;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TexturePropertyNode;55;-41.39324,-742.7098;Inherit;True;Property;_Texture0;Texture 0;9;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;1;-1088,-199.5;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;39;90.37756,-228.2284;Inherit;False;Constant;_Color0;Color 0;1;0;Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;840.6,-156;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;CwanShader/Flag;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;False;Transparent;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;12;0;2;1
WireConnection;12;1;2;2
WireConnection;12;2;13;0
WireConnection;9;0;12;0
WireConnection;9;1;10;2
WireConnection;29;0;2;2
WireConnection;29;1;31;0
WireConnection;14;0;2;2
WireConnection;14;1;15;0
WireConnection;18;0;14;0
WireConnection;67;0;9;0
WireConnection;67;1;68;0
WireConnection;49;0;2;1
WireConnection;49;1;2;2
WireConnection;49;2;50;0
WireConnection;30;0;29;0
WireConnection;32;0;30;0
WireConnection;32;1;33;0
WireConnection;34;0;49;0
WireConnection;34;1;10;2
WireConnection;23;0;18;0
WireConnection;23;1;67;0
WireConnection;27;0;23;0
WireConnection;27;1;28;0
WireConnection;35;0;32;0
WireConnection;35;1;34;0
WireConnection;37;0;27;0
WireConnection;37;1;35;0
WireConnection;37;2;38;0
WireConnection;57;0;37;0
WireConnection;57;1;56;0
WireConnection;58;0;57;0
WireConnection;58;1;59;0
WireConnection;61;0;52;0
WireConnection;61;1;58;0
WireConnection;61;2;62;0
WireConnection;54;1;55;0
WireConnection;0;0;61;0
WireConnection;0;4;58;0
WireConnection;0;11;37;0
ASEEND*/
//CHKSM=D2B09070A35C5E43FEB66A219C37D389141E8F73
// Upgrade NOTE: upgraded instancing buffer 'CwanShaderleafVertexWave' to new syntax.

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "CwanShader/leaf/VertexWave"
{
	Properties
	{
		_BaseAlbedo("BaseAlbedo", 2D) = "white" {}
		_MaskClip("MaskClip", Range( 0 , 1)) = 0
		_Color("Color", Color) = (0,0,0,0)
		_AOBlend("AOBlend", Range( 0 , 1)) = 0
		_Smoothness("Smoothness", Range( 0 , 1)) = 0.5
		[Header(WaveOption)]_WaveIntensity("WaveIntensity", Range( 0 , 3)) = 0
		_WaveRandam("WaveRandam", Range( 0 , 1)) = 0
		_AllScrollx("AllScroll : x", Float) = 1
		_AllScrolly("AllScroll : y", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" }
		Cull Off
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma multi_compile_instancing
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform float _WaveRandam;
		uniform float _WaveIntensity;
		uniform float _AllScrollx;
		uniform float _AllScrolly;
		uniform float4 _Color;
		uniform sampler2D _BaseAlbedo;
		uniform float _AOBlend;
		uniform float _MaskClip;

		UNITY_INSTANCING_BUFFER_START(CwanShaderleafVertexWave)
			UNITY_DEFINE_INSTANCED_PROP(float4, _BaseAlbedo_ST)
#define _BaseAlbedo_ST_arr CwanShaderleafVertexWave
			UNITY_DEFINE_INSTANCED_PROP(float, _Smoothness)
#define _Smoothness_arr CwanShaderleafVertexWave
		UNITY_INSTANCING_BUFFER_END(CwanShaderleafVertexWave)


		float2 voronoihash173( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi173( float2 v, float time, inout float2 id, inout float2 mr, float smoothness, inout float2 smoothId )
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
			 		float2 o = voronoihash173( n + g );
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


		float2 voronoihash178( float2 p )
		{
			p = p - 57 * floor( p / 57 );
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi178( float2 v, float time, inout float2 id, inout float2 mr, float smoothness, inout float2 smoothId )
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
			 		float2 o = voronoihash178( n + g );
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


		float2 voronoihash266( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi266( float2 v, float time, inout float2 id, inout float2 mr, float smoothness, inout float2 smoothId )
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
			 		float2 o = voronoihash266( n + g );
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


		float2 voronoihash185( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi185( float2 v, float time, inout float2 id, inout float2 mr, float smoothness, inout float2 smoothId )
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
			 		float2 o = voronoihash185( n + g );
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
			return F2 - F1;
		}


		float4 CalculateContrast( float contrastValue, float4 colorTarget )
		{
			float t = 0.5 * ( 1.0 - contrastValue );
			return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
		}

		inline float2 UnityVoronoiRandomVector( float2 UV, float offset )
		{
			float2x2 m = float2x2( 15.27, 47.63, 99.41, 89.98 );
			UV = frac( sin(mul(UV, m) ) * 46839.32 );
			return float2( sin(UV.y* +offset ) * 0.5 + 0.5, cos( UV.x* offset ) * 0.5 + 0.5 );
		}
		
		//x - Out y - Cells
		float3 UnityVoronoi( float2 UV, float AngleOffset, float CellDensity, inout float2 mr )
		{
			float2 g = floor( UV * CellDensity );
			float2 f = frac( UV * CellDensity );
			float t = 8.0;
			float3 res = float3( 8.0, 0.0, 0.0 );
		
			for( int y = -1; y <= 1; y++ )
			{
				for( int x = -1; x <= 1; x++ )
				{
					float2 lattice = float2( x, y );
					float2 offset = UnityVoronoiRandomVector( lattice + g, AngleOffset );
					float d = distance( lattice + offset, f );
		
					if( d < res.x )
					{
						mr = f - lattice - offset;
						res = float3( d, offset.x, offset.y );
					}
				}
			}
			return res;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 break3_g1 = ase_vertex3Pos;
			float VertexG93 = v.color.g;
			float Frequency12 = ( _WaveRandam * VertexG93 );
			float temp_output_47_0 = (0.0 + (ase_vertex3Pos.y - 0.0) * (12.23 - 0.0) / (20.0 - 0.0));
			float mulTime4_g1 = _Time.y * 2.0;
			float Ampritude10 = _WaveIntensity;
			float temp_output_182_0 = ( _Time.y * 0.3 );
			float time173 = temp_output_182_0;
			float2 voronoiSmoothId173 = 0;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float2 appendResult259 = (float2((0.0 + (ase_worldPos.x - 0.0) * (1.0 - 0.0) / (20.0 - 0.0)) , (0.0 + (ase_worldPos.z - 0.0) * (1.0 - 0.0) / (20.0 - 0.0))));
			float2 panner172 = ( _Time.x * float2( 0,0 ) + appendResult259);
			float2 coords173 = panner172 * 1.0;
			float2 id173 = 0;
			float2 uv173 = 0;
			float voroi173 = voronoi173( coords173, time173, id173, uv173, 0, voronoiSmoothId173 );
			float2 temp_cast_1 = (voroi173).xx;
			float2 panner280 = ( 1.0 * _Time.y * float2( 0,0 ) + temp_cast_1);
			float temp_output_127_0 = ( ase_worldPos.x * 100.0 );
			float temp_output_128_0 = ( ase_worldPos.z * 100.0 );
			float2 appendResult126 = (float2(temp_output_127_0 , temp_output_128_0));
			float2 appendResult130 = (float2(temp_output_128_0 , temp_output_127_0));
			float time178 = _Time.w;
			float2 voronoiSmoothId178 = 0;
			float2 coords178 = panner172 * ( ( float2( 0,0 ) + appendResult126 ) * ( v.texcoord.xy + appendResult130 ) ).x;
			float2 id178 = 0;
			float2 uv178 = 0;
			float voroi178 = voronoi178( coords178, time178, id178, uv178, 0, voronoiSmoothId178 );
			float time266 = 1.0;
			float2 voronoiSmoothId266 = 0;
			float2 appendResult264 = (float2(_AllScrollx , _AllScrolly));
			float2 panner265 = ( 1.0 * _Time.y * appendResult264 + appendResult259);
			float2 coords266 = panner265 * 1.0;
			float2 id266 = 0;
			float2 uv266 = 0;
			float voroi266 = voronoi266( coords266, time266, id266, uv266, 0, voronoiSmoothId266 );
			float temp_output_278_0 = (0.0 + (voroi266 - 0.2) * (1.0 - 0.0) / (1.0 - 0.2));
			float time185 = ( _Time.x * 5.0 );
			float2 voronoiSmoothId185 = 0;
			float2 temp_cast_4 = (v.texcoord.xy.x).xx;
			float2 panner188 = ( ( _Time.w * 72.82 ) * float2( 0,0 ) + temp_cast_4);
			float2 coords185 = panner188 * 1.0;
			float2 id185 = 0;
			float2 uv185 = 0;
			float voroi185 = voronoi185( coords185, time185, id185, uv185, 0, voronoiSmoothId185 );
			float lerpResult279 = lerp( temp_output_278_0 , voroi185 , 1.0);
			float4 temp_cast_5 = (( lerpResult279 + -0.63 )).xxxx;
			float2 uv211 = 0;
			float3 unityVoronoy211 = UnityVoronoi(panner172,temp_output_182_0,50.0,uv211);
			float4 WaveNoise54 = ( float4( ( panner280 * voroi178 ), 0.0 , 0.0 ) * ( ( CalculateContrast(1.0,temp_cast_5) * unityVoronoy211.x ) * -1.0 ) );
			float3 appendResult11_g1 = (float3(break3_g1.x , ( break3_g1.y + ( sin( ( ( break3_g1.x * ( Frequency12 * temp_output_47_0 ) ) + mulTime4_g1 ) ) * ( float4( ( Ampritude10 * v.texcoord.xy ), 0.0 , 0.0 ) * ( temp_output_47_0 * WaveNoise54 ) ).r ) ) , break3_g1.z));
			float3 newvertexPos20 = appendResult11_g1;
			v.vertex.xyz = newvertexPos20;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 _BaseAlbedo_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_BaseAlbedo_ST_arr, _BaseAlbedo_ST);
			float2 uv_BaseAlbedo = i.uv_texcoord * _BaseAlbedo_ST_Instance.xy + _BaseAlbedo_ST_Instance.zw;
			float4 tex2DNode1 = tex2D( _BaseAlbedo, uv_BaseAlbedo );
			float3 ase_worldPos = i.worldPos;
			float time266 = 1.0;
			float2 voronoiSmoothId266 = 0;
			float2 appendResult264 = (float2(_AllScrollx , _AllScrolly));
			float2 appendResult259 = (float2((0.0 + (ase_worldPos.x - 0.0) * (1.0 - 0.0) / (20.0 - 0.0)) , (0.0 + (ase_worldPos.z - 0.0) * (1.0 - 0.0) / (20.0 - 0.0))));
			float2 panner265 = ( 1.0 * _Time.y * appendResult264 + appendResult259);
			float2 coords266 = panner265 * 1.0;
			float2 id266 = 0;
			float2 uv266 = 0;
			float voroi266 = voronoi266( coords266, time266, id266, uv266, 0, voronoiSmoothId266 );
			float temp_output_278_0 = (0.0 + (voroi266 - 0.2) * (1.0 - 0.0) / (1.0 - 0.2));
			float temp_output_284_0 = (-0.2 + (temp_output_278_0 - 0.0) * (0.2 - -0.2) / (1.0 - 0.0));
			float clampResult287 = clamp( ( ( _Color.a + (-0.1 + (frac( ( ase_worldPos.x + ase_worldPos.z ) ) - 0.0) * (0.1 - -0.1) / (1.0 - 0.0)) ) + temp_output_284_0 ) , 0.0 , 1.0 );
			float4 lerpResult91 = lerp( CalculateContrast(( _Color.a * 3.0 ),tex2DNode1) , _Color , clampResult287);
			o.Albedo = lerpResult91.rgb;
			float _Smoothness_Instance = UNITY_ACCESS_INSTANCED_PROP(_Smoothness_arr, _Smoothness);
			o.Smoothness = _Smoothness_Instance;
			float VertexR86 = ( 1.0 - ( ( 1.0 - i.vertexColor.r ) * _AOBlend ) );
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			o.Occlusion = ( VertexR86 + ( (0.0 + (ase_vertex3Pos.y - 0.0) * (0.8 - 0.0) / (20.0 - 0.0)) * temp_output_284_0 ) );
			o.Alpha = _MaskClip;
			clip( tex2DNode1.a - _MaskClip );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				half4 color : COLOR0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.color = v.color;
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.vertexColor = IN.color;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
0;0;1920;1019;2799.22;54.24118;1.3;True;False
Node;AmplifyShaderEditor.CommentaryNode;296;-2863.153,15.35475;Inherit;False;3426;1097;WaveControll;36;217;213;186;211;212;201;202;178;172;182;184;203;279;185;278;266;188;187;193;171;125;129;126;130;121;127;128;174;262;263;264;265;280;173;54;301;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;301;-2848,208;Inherit;False;762.1531;434.3547;WorldPos=>UV;6;259;267;268;269;270;258;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;269;-2797.153,433.3547;Inherit;False;Constant;_Float7;Float 7;12;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;270;-2797.153,513.3547;Inherit;False;Constant;_Float8;Float 8;12;0;Create;True;0;0;0;False;0;False;20;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;258;-2813.153,257.3547;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;262;-2509.153,721.3547;Inherit;False;Property;_AllScrollx;AllScroll : x;7;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;268;-2589.153,433.3547;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-50;False;2;FLOAT;50;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;263;-2509.153,817.3547;Inherit;False;Property;_AllScrolly;AllScroll : y;8;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;267;-2589.153,257.3547;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-50;False;2;FLOAT;50;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;174;-2061.153,273.3547;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;264;-2317.153,721.3547;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;259;-2336,256;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;265;-2061.153,705.3547;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;171;-2068.527,421.6395;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;193;-1821.153,897.3547;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;72.82;False;1;FLOAT;0
Node;AmplifyShaderEditor.VoronoiNode;266;-1789.153,705.3547;Inherit;False;0;0;1;0;1;False;1;False;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.WorldPosInputsNode;121;-2045.153,65.35474;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PannerNode;188;-1629.153,849.3547;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;187;-1629.153,977.3547;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;127;-1821.153,65.35474;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;100;False;1;FLOAT;0
Node;AmplifyShaderEditor.VoronoiNode;185;-1405.153,849.3547;Inherit;False;0;0;1;2;1;False;1;False;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.TFHCRemapNode;278;-1520,704;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0.2;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;128;-1821.153,177.3548;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;100;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;126;-1645.153,65.35474;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;130;-1645.153,177.3548;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;279;-1181.153,705.3547;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;182;-1181.153,481.3546;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;129;-1485.153,177.3548;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;125;-1485.153,65.35474;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;172;-1293.153,257.3547;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;203;-893.1533,577.3547;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-0.63;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;186;-701.1534,577.3547;Inherit;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.VoronoiNode;173;-895.1376,257.3547;Inherit;False;0;0;1;0;1;False;1;False;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.CommentaryNode;132;-2864,-384;Inherit;False;898;353;VertexColorControl;9;85;117;115;118;86;93;116;133;134;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;184;-1181.153,593.3547;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.VoronoiNode;211;-685.1534,721.3547;Inherit;False;0;0;1;1;1;False;1;True;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;50;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.VertexColorNode;85;-2816,-240;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;212;-445.1534,577.3547;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;202;-429.1534,737.3547;Inherit;False;Constant;_Float2;Float 2;12;0;Create;True;0;0;0;False;0;False;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VoronoiNode;178;-893.1533,387.4641;Inherit;False;0;0;1;0;1;True;57;False;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.PannerNode;280;-541.1534,257.3547;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;299;-736,-1168;Inherit;False;1624;1142;ColorControll;22;87;295;5;29;1;96;98;91;287;140;150;83;151;147;292;288;297;291;289;284;0;7;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;298;-2864,-768;Inherit;False;834;358;WaveInput;6;9;11;10;95;94;12;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;213;-189.1534,257.3547;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;93;-2448,-208;Float;False;VertexG;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;201;-221.1533,577.3547;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;94;-2688,-528;Inherit;False;93;VertexG;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-2800,-720;Inherit;False;Property;_WaveIntensity;WaveIntensity;5;1;[Header];Create;True;1;WaveOption;0;0;False;0;False;0;0.76;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;137;-1936,-720;Inherit;False;1138;694;NewVertexPosition;14;27;28;22;53;51;19;18;101;25;46;47;48;56;20;;1,0.7971698,0.7971698,1;0;0
Node;AmplifyShaderEditor.WorldPosInputsNode;140;-688,-736;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;217;66.8467,257.3547;Inherit;False;2;2;0;FLOAT2;0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-2800,-624;Inherit;False;Property;_WaveRandam;WaveRandam;6;0;Create;True;1;WaveOption;0;0;False;0;False;0;0.6694566;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;95;-2464,-624;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;147;-384,-864;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;10;-2240,-720;Float;False;Ampritude;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;54;338.8468,257.3547;Float;False;WaveNoise;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-1824,-176;Float;False;Constant;_Wave;Wave;6;0;Create;True;0;0;0;False;0;False;12.23;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;46;-1872,-320;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;12;-2240,-624;Float;False;Frequency;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;118;-2816,-336;Inherit;False;Property;_AOBlend;AOBlend;3;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;151;-224,-864;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;116;-2640,-208;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;27;-1872,-512;Inherit;False;10;Ampritude;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;25;-1888,-448;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;56;-1584,-144;Inherit;False;54;WaveNoise;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;47;-1664,-368;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;20;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;83;-688,-928;Float;False;Property;_Color;Color;2;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.990566,0.6470831,0.5466803,0.3058824;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;117;-2496,-336;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-1616,-464;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;150;-80,-864;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-0.1;False;4;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;22;-1696,-608;Inherit;False;12;Frequency;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;-1360,-304;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;115;-2336,-336;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;284;-448,-384;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-0.2;False;4;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;288;-288,-688;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-1360,-464;Inherit;False;2;2;0;FLOAT2;0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;101;-1440,-592;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;19;-1872,-672;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode;289;-592,-560;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;18;-1280,-672;Inherit;False;Waving Vertex;-1;;1;872b3757863bb794c96291ceeebfb188;0;3;1;FLOAT3;0,0,0;False;12;FLOAT;0;False;13;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;86;-2192,-336;Float;False;VertexR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;291;-368,-560;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;20;False;3;FLOAT;0;False;4;FLOAT;0.8;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;98;-288,-1072;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-688,-1119;Inherit;True;Property;_BaseAlbedo;BaseAlbedo;0;0;Create;True;0;0;0;False;1;;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;292;48,-688;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;20;-1072,-672;Float;False;newvertexPos;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;87;-32,-416;Inherit;False;86;VertexR;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;297;-32,-336;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;96;-144,-1104;Inherit;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;2.15;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;287;96,-1008;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;134;-2448,-112;Inherit;False;VertexA;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;91;256,-1104;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;133;-2256,-176;Inherit;False;VertexB;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;295;144,-416;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;128,-304;Float;False;InstancedProperty;_Smoothness;Smoothness;4;0;Create;False;0;0;0;False;0;False;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;128,-224;Inherit;False;Property;_MaskClip;MaskClip;1;0;Create;True;0;0;0;False;0;False;0;0.487;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;7;208,-144;Inherit;False;20;newvertexPos;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;624,-528;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;CwanShader/leaf/VertexWave;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Absolute;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;True;29;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;268;0;258;3
WireConnection;268;1;269;0
WireConnection;268;2;270;0
WireConnection;267;0;258;1
WireConnection;267;1;269;0
WireConnection;267;2;270;0
WireConnection;264;0;262;0
WireConnection;264;1;263;0
WireConnection;259;0;267;0
WireConnection;259;1;268;0
WireConnection;265;0;259;0
WireConnection;265;2;264;0
WireConnection;193;0;174;4
WireConnection;266;0;265;0
WireConnection;188;0;171;1
WireConnection;188;1;193;0
WireConnection;187;0;174;1
WireConnection;127;0;121;1
WireConnection;185;0;188;0
WireConnection;185;1;187;0
WireConnection;278;0;266;0
WireConnection;128;0;121;3
WireConnection;126;0;127;0
WireConnection;126;1;128;0
WireConnection;130;0;128;0
WireConnection;130;1;127;0
WireConnection;279;0;278;0
WireConnection;279;1;185;0
WireConnection;182;0;174;2
WireConnection;129;0;171;0
WireConnection;129;1;130;0
WireConnection;125;1;126;0
WireConnection;172;0;259;0
WireConnection;172;1;174;1
WireConnection;203;0;279;0
WireConnection;186;1;203;0
WireConnection;173;0;172;0
WireConnection;173;1;182;0
WireConnection;184;0;125;0
WireConnection;184;1;129;0
WireConnection;211;0;172;0
WireConnection;211;1;182;0
WireConnection;212;0;186;0
WireConnection;212;1;211;0
WireConnection;178;0;172;0
WireConnection;178;1;174;4
WireConnection;178;2;184;0
WireConnection;280;0;173;0
WireConnection;213;0;280;0
WireConnection;213;1;178;0
WireConnection;93;0;85;2
WireConnection;201;0;212;0
WireConnection;201;1;202;0
WireConnection;217;0;213;0
WireConnection;217;1;201;0
WireConnection;95;0;11;0
WireConnection;95;1;94;0
WireConnection;147;0;140;1
WireConnection;147;1;140;3
WireConnection;10;0;9;0
WireConnection;54;0;217;0
WireConnection;12;0;95;0
WireConnection;151;0;147;0
WireConnection;116;0;85;1
WireConnection;47;0;46;2
WireConnection;47;4;48;0
WireConnection;117;0;116;0
WireConnection;117;1;118;0
WireConnection;28;0;27;0
WireConnection;28;1;25;0
WireConnection;150;0;151;0
WireConnection;53;0;47;0
WireConnection;53;1;56;0
WireConnection;115;1;117;0
WireConnection;284;0;278;0
WireConnection;288;0;83;4
WireConnection;288;1;150;0
WireConnection;51;0;28;0
WireConnection;51;1;53;0
WireConnection;101;0;22;0
WireConnection;101;1;47;0
WireConnection;18;1;19;0
WireConnection;18;12;101;0
WireConnection;18;13;51;0
WireConnection;86;0;115;0
WireConnection;291;0;289;2
WireConnection;98;0;83;4
WireConnection;292;0;288;0
WireConnection;292;1;284;0
WireConnection;20;0;18;0
WireConnection;297;0;291;0
WireConnection;297;1;284;0
WireConnection;96;1;1;0
WireConnection;96;0;98;0
WireConnection;287;0;292;0
WireConnection;134;0;85;4
WireConnection;91;0;96;0
WireConnection;91;1;83;0
WireConnection;91;2;287;0
WireConnection;133;0;85;3
WireConnection;295;0;87;0
WireConnection;295;1;297;0
WireConnection;0;0;91;0
WireConnection;0;4;5;0
WireConnection;0;5;295;0
WireConnection;0;9;29;0
WireConnection;0;10;1;4
WireConnection;0;11;7;0
ASEEND*/
//CHKSM=36DB70511CF0C53D9B0B4D7825B5C758E326FEC1
// Upgrade NOTE: replaced tex2D unity_Lightmap with UNITY_SAMPLE_TEX2D

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "CwanShader/Rock_CCA"
{
	Properties
	{
		_Tri_albed("Tri_albed", 2D) = "white" {}
		_Tri_normal("Tri_normal", 2D) = "bump" {}
		_CCAmask("CCAmask", 2D) = "white" {}
		_Normal_Detail("Normal_Detail", 2D) = "white" {}
		_Smoothness("Smoothness", Range( 0 , 1)) = -0.5
		_SmoothBalamce("SmoothBalamce", Range( -1 , 0)) = 0
		_Curveture1("Curveture1", Range( 0 , 1)) = 0
		_Curveture2("Curveture2", Range( 0 , 1)) = 1
		_AO("AO", Range( 0 , 1)) = 1
		_Moss("Moss", 2D) = "white" {}
		_MossColor("MossColor", Color) = (0,0,0,0)
		_LighjtRange("LighjtRange", Range( 0 , 1)) = 0.2
		_WL("W=L", Range( 0 , 1)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
			float2 vertexToFrag10_g1;
		};

		uniform sampler2D _Normal_Detail;
		uniform float4 _Normal_Detail_ST;
		sampler2D _Tri_normal;
		uniform sampler2D _Moss;
		uniform float4 _Moss_ST;
		uniform float4 _MossColor;
		uniform sampler2D _Tri_albed;
		uniform sampler2D _CCAmask;
		uniform float4 _CCAmask_ST;
		uniform float _Curveture1;
		uniform float _Curveture2;
		uniform float _LighjtRange;
		uniform float _WL;
		uniform float _AO;
		uniform float _Smoothness;
		uniform float _SmoothBalamce;


		inline float3 TriplanarSampling4( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
		{
			float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
			projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
			float3 nsign = sign( worldNormal );
			half4 xNorm; half4 yNorm; half4 zNorm;
			xNorm = tex2D( topTexMap, tiling * worldPos.zy * float2(  nsign.x, 1.0 ) );
			yNorm = tex2D( topTexMap, tiling * worldPos.xz * float2(  nsign.y, 1.0 ) );
			zNorm = tex2D( topTexMap, tiling * worldPos.xy * float2( -nsign.z, 1.0 ) );
			xNorm.xyz  = half3( UnpackNormal( xNorm ).xy * float2(  nsign.x, 1.0 ) + worldNormal.zy, worldNormal.x ).zyx;
			yNorm.xyz  = half3( UnpackNormal( yNorm ).xy * float2(  nsign.y, 1.0 ) + worldNormal.xz, worldNormal.y ).xzy;
			zNorm.xyz  = half3( UnpackNormal( zNorm ).xy * float2( -nsign.z, 1.0 ) + worldNormal.xy, worldNormal.z ).xyz;
			return normalize( xNorm.xyz * projNormal.x + yNorm.xyz * projNormal.y + zNorm.xyz * projNormal.z );
		}


		inline float4 TriplanarSampling2( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
		{
			float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
			projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
			float3 nsign = sign( worldNormal );
			half4 xNorm; half4 yNorm; half4 zNorm;
			xNorm = tex2D( topTexMap, tiling * worldPos.zy * float2(  nsign.x, 1.0 ) );
			yNorm = tex2D( topTexMap, tiling * worldPos.xz * float2(  nsign.y, 1.0 ) );
			zNorm = tex2D( topTexMap, tiling * worldPos.xy * float2( -nsign.z, 1.0 ) );
			return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
		}


		inline float4 TriplanarSampling48( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
		{
			float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
			projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
			float3 nsign = sign( worldNormal );
			half4 xNorm; half4 yNorm; half4 zNorm;
			xNorm = tex2D( topTexMap, tiling * worldPos.zy * float2(  nsign.x, 1.0 ) );
			yNorm = tex2D( topTexMap, tiling * worldPos.xz * float2(  nsign.y, 1.0 ) );
			zNorm = tex2D( topTexMap, tiling * worldPos.xy * float2( -nsign.z, 1.0 ) );
			return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
		}


		inline float4 TriplanarSampling131( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
		{
			float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
			projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
			float3 nsign = sign( worldNormal );
			half4 xNorm; half4 yNorm; half4 zNorm;
			xNorm = tex2D( topTexMap, tiling * worldPos.zy * float2(  nsign.x, 1.0 ) );
			yNorm = tex2D( topTexMap, tiling * worldPos.xz * float2(  nsign.y, 1.0 ) );
			zNorm = tex2D( topTexMap, tiling * worldPos.xy * float2( -nsign.z, 1.0 ) );
			return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.vertexToFrag10_g1 = ( ( v.texcoord1.xy * (unity_LightmapST).xy ) + (unity_LightmapST).zw );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal_Detail = i.uv_texcoord * _Normal_Detail_ST.xy + _Normal_Detail_ST.zw;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3x3 ase_worldToTangent = float3x3( ase_worldTangent, ase_worldBitangent, ase_worldNormal );
			float3 triplanar4 = TriplanarSampling4( _Tri_normal, ase_worldPos, ase_worldNormal, 1.0, float2( 1,1 ), 1.0, 0 );
			float3 tanTriplanarNormal4 = mul( ase_worldToTangent, triplanar4 );
			float4 lerpResult149 = lerp( tex2D( _Normal_Detail, uv_Normal_Detail ) , float4( tanTriplanarNormal4 , 0.0 ) , 0.6);
			float4 Normal_Output163 = lerpResult149;
			o.Normal = (Normal_Output163).rgb;
			float2 uv_Moss = i.uv_texcoord * _Moss_ST.xy + _Moss_ST.zw;
			float4 lerpResult224 = lerp( tex2D( _Moss, uv_Moss ) , float4( (_MossColor).rgb , 0.0 ) , _MossColor.a);
			float4 triplanar2 = TriplanarSampling2( _Tri_albed, ase_worldPos, ase_worldNormal, 1.0, float2( 1,1 ), 1.0, 0 );
			float3 TriBase19 = (triplanar2).xyz;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			ase_vertexNormal = normalize( ase_vertexNormal );
			float4 triplanar48 = TriplanarSampling48( _Tri_albed, ase_vertex3Pos, ase_vertexNormal, 1.0, float2( 5,1 ), 1.0, 0 );
			float TriDirt43 = ( 0.0 + triplanar48.w );
			float2 uv_CCAmask = i.uv_texcoord * _CCAmask_ST.xy + _CCAmask_ST.zw;
			float4 tex2DNode6 = tex2D( _CCAmask, uv_CCAmask );
			float R115 = tex2DNode6.r;
			float lerpResult16 = lerp( 1.0 , ( TriDirt43 * R115 ) , _Curveture1);
			float G116 = tex2DNode6.g;
			float4 triplanar131 = TriplanarSampling131( _Tri_albed, ase_vertex3Pos, ase_vertexNormal, 1.0, float2( 3,3 ), 1.0, 0 );
			float TriDirt2132 = triplanar131.w;
			float lerpResult21 = lerp( lerpResult16 , ( ( G116 * 1.3 ) * TriDirt2132 ) , _Curveture2);
			float Mask_Output121 = ( ( lerpResult16 + lerpResult21 ) * 0.5 );
			float4 tex2DNode7_g1 = UNITY_SAMPLE_TEX2D( unity_Lightmap, i.vertexToFrag10_g1 );
			float3 decodeLightMap6_g1 = DecodeLightmap(tex2DNode7_g1);
			float3 Fetch_Lightmap173 = decodeLightMap6_g1;
			float lerpResult217 = lerp( saturate( ( ( ( (saturate( ( Fetch_Lightmap173 + _LighjtRange ) )).x - 0.5 ) * 10.0 ) + 0.5 ) ) , saturate( ( ((WorldNormalVector( i , Normal_Output163.rgb ))).y + 0.2 ) ) , _WL);
			float4 lerpResult221 = lerp( lerpResult224 , float4( (( TriBase19 * Mask_Output121 )).xyz , 0.0 ) , lerpResult217);
			o.Albedo = lerpResult221.rgb;
			float B125 = tex2DNode6.b;
			float3 temp_output_73_0 = ( ( ( 1.0 - ( B125 * _AO ) ) + Fetch_Lightmap173 ) * Fetch_Lightmap173 );
			float Mask_smooth112 = tex2DNode6.a;
			float Tri_smooth109 = triplanar2.a;
			float lerpResult151 = lerp( Mask_smooth112 , Tri_smooth109 , 0.5);
			float3 Smooth_Output145 = ( ( ( temp_output_73_0 + 0.1 ) * lerpResult151 ) + ( _Smoothness + -1.5 ) );
			o.Smoothness = ( (Smooth_Output145).x + _SmoothBalamce );
			float3 AO_Output126 = temp_output_73_0;
			o.Occlusion = (AO_Output126).xyzz.x;
			o.Alpha = 1;
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
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float4 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
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
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.customPack1.zw = customInputData.vertexToFrag10_g1;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
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
				surfIN.vertexToFrag10_g1 = IN.customPack1.zw;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
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
0;0;1920;1019;844.8248;1017.152;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;172;-2482,-1138;Inherit;False;447;1101.747;Input_texture;4;46;97;4;6;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;137;-1744,-1312;Inherit;False;714;675;Triplanar;10;136;48;134;2;108;131;43;19;109;132;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TexturePropertyNode;46;-2432,-1088;Inherit;True;Property;_Tri_albed;Tri_albed;0;0;Create;True;0;0;0;False;0;False;None;4abc546967747d046a7038807d888a29;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RangedFloatNode;136;-1328,-1040;Inherit;False;Constant;_Float0;Float 0;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TriplanarNode;48;-1696,-1056;Inherit;True;Spherical;Object;False;Top Texture 2;_TopTexture2;white;0;None;Mid Texture 2;_MidTexture2;white;-1;None;Bot Texture 2;_BotTexture2;white;-1;None;TriDirt;Tangent;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT2;5,1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;134;-1184,-976;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;124;-1744,944;Inherit;False;964;262;AO;7;37;59;93;73;25;125;126;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;6;-2412.813,-266.2531;Inherit;True;Property;_CCAmask;CCAmask;4;0;Create;True;0;0;0;False;0;False;-1;3d2a9ee9fc20a304ab55293e6099fa48;3d2a9ee9fc20a304ab55293e6099fa48;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;25;-1712,1088;Inherit;False;Property;_AO;AO;10;0;Create;True;0;0;0;False;0;False;1;0.552;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;88;-2464,32;Inherit;False;FetchLightmapValue;2;;1;43de3d4ae59f645418fdd020d1b8e78e;0;0;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;125;-1776,992;Inherit;False;B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TriplanarNode;131;-1696,-864;Inherit;True;Spherical;Object;False;Top Texture 1;_TopTexture1;white;0;None;Mid Texture 3;_MidTexture3;white;-1;None;Bot Texture 3;_BotTexture3;white;-1;None;TriDirt2;Tangent;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT2;3,3;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;43;-1056,-960;Inherit;False;TriDirt;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;120;-1744,-192;Inherit;False;1442.062;666.7103;Mask_Detail;15;66;16;23;13;103;104;21;63;28;62;116;115;121;129;138;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-1456,992;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;167;-1744,-608;Inherit;False;486.9138;386.6306;Normal_controll;3;149;150;163;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;104;-1696,-144;Inherit;False;43;TriDirt;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;116;-1792,176;Inherit;False;G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;132;-1088,-768;Inherit;False;TriDirt2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;115;-1792,-64;Inherit;False;R;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;173;-2240,32;Inherit;False;Fetch_Lightmap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;150;-1728,-336;Inherit;False;Constant;_Float3;Float 3;10;0;Create;True;0;0;0;False;0;False;0.6;0.6;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;209;-974.0001,-1828.6;Inherit;False;173;Fetch_Lightmap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1600,96;Inherit;False;Property;_Curveture1;Curveture1;8;0;Create;True;0;0;0;False;0;False;0;0.64;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;97;-2432,-768;Inherit;True;Property;_Normal_Detail;Normal_Detail;5;0;Create;True;0;0;0;False;0;False;-1;None;4c27218c0d3f05c4ca140ac1f6c82ed3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TriplanarNode;4;-2432,-560;Inherit;True;Spherical;World;True;Tri_normal;_Tri_normal;bump;1;None;Mid Texture 1;_MidTexture1;white;-1;None;Bot Texture 1;_BotTexture1;white;-1;None;Normal:Rough;Tangent;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT2;1,1;False;4;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;214;-974.0001,-1748.6;Inherit;False;Property;_LighjtRange;LighjtRange;13;0;Create;True;0;0;0;False;0;False;0.2;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TriplanarNode;2;-1696,-1248;Inherit;True;Spherical;World;False;Top Texture 0;_TopTexture0;white;0;None;Mid Texture 0;_MidTexture0;white;-1;None;Bot Texture 0;_BotTexture0;white;-1;None;TriBase;Tangent;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT2;1,1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;-1536,176;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1.3;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;138;-1525.2,300.1;Inherit;False;132;TriDirt2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;59;-1296,992;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;174;-1312,1120;Inherit;False;173;Fetch_Lightmap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;103;-1536,-144;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;212;-750.0001,-1828.6;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;129;-1280,176;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;16;-1296,-48;Inherit;True;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-1328,272;Inherit;False;Property;_Curveture2;Curveture2;9;0;Create;True;0;0;0;False;0;False;1;0.716;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;93;-1104,992;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;109;-1088,-1152;Inherit;False;Tri_smooth;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;149;-1488,-528;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;162;-1744,496;Inherit;False;1066;406;Smoothness;12;139;151;142;161;159;144;155;157;156;154;112;145;;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;21;-1024,128;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;163;-1312,-528;Inherit;False;Normal_Output;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;-976,1056;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;208;-274,-1867.6;Inherit;False;936.8185;298.9611;Comment;6;203;202;205;204;206;207;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;213;-606.0001,-1828.6;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;139;-1680,672;Inherit;False;109;Tri_smooth;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;161;-1520,560;Inherit;False;Constant;_Float4;Float 4;10;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;112;-1776,576;Inherit;False;Mask_smooth;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;142;-1664,768;Inherit;False;Constant;_Float1;Float 1;9;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;159;-1296,528;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode;215;-446,-1828.6;Inherit;False;FLOAT;0;1;2;3;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;151;-1472,640;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;157;-1184,768;Inherit;False;Constant;_Float2;Float 2;10;0;Create;True;0;0;0;False;0;False;-1.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;196;-688,-1424;Inherit;False;163;Normal_Output;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;28;-752,128;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;155;-1312,688;Inherit;False;Property;_Smoothness;Smoothness;6;0;Create;True;0;0;0;False;0;False;-0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;203;-226,-1723.6;Inherit;False;Constant;_Float6;Float 6;9;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;63;-688,352;Inherit;False;Constant;_tyousei;tyousei;6;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;205;-17.99998,-1691.6;Inherit;False;Constant;_Float7;Float 7;9;0;Create;True;0;0;0;False;0;False;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;156;-1008,672;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;202;-17.99998,-1819.6;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;144;-1152,576;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode;108;-1264,-1264;Inherit;False;FLOAT3;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldNormalVector;197;-448,-1424;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;-528,128;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;121;-384,128;Inherit;False;Mask_Output;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;19;-1088,-1264;Inherit;False;TriBase;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;200;-144,-1328;Inherit;False;Constant;_Float5;Float 5;9;0;Create;True;0;0;0;False;0;False;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;204;158,-1819.6;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;198;-224,-1424;Inherit;False;False;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;154;-880,576;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;225;-752,-1104;Inherit;False;Property;_MossColor;MossColor;12;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0.1981129,0.04661463,0.5372549;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;35;-733.3802,-715.8627;Inherit;False;19;TriBase;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;206;350,-1819.6;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;145;-736,576;Inherit;False;Smooth_Output;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;169;-733.3049,-623.1522;Inherit;False;121;Mask_Output;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;199;48,-1424;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;201;304,-1424;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;126;-816,1056;Inherit;False;AO_Output;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;207;494,-1819.6;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;218;128,-1280;Inherit;False;Property;_WL;W=L;14;0;Create;True;0;0;0;False;0;False;1;0.653;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;170;-637.7263,-458.3127;Inherit;False;145;Smooth_Output;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;222;-784,-1328;Inherit;True;Property;_Moss;Moss;11;0;Create;True;0;0;0;False;0;False;-1;None;6c28d5fcf391c8049a063c96434736e4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-509.3802,-651.8627;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode;226;-512,-1136;Inherit;False;FLOAT3;0;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;224;-320,-1168;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;171;-637.7263,-378.3127;Inherit;False;126;AO_Output;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode;122;-340.3802,-662.8627;Inherit;False;FLOAT3;0;1;2;3;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode;146;-336,-480;Inherit;False;FLOAT;0;1;2;3;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;217;640,-1392;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;164;-637.3802,-539.8627;Inherit;False;163;Normal_Output;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;254;-149.9404,-434.4935;Inherit;False;Property;_SmoothBalamce;SmoothBalamce;7;0;Create;True;0;0;0;False;0;False;0;-0.871;-1;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;128;-336,-400;Inherit;False;FLOAT4;0;1;2;3;1;0;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;253;85.71,-558.6534;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;221;32,-816;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SwizzleNode;165;-333.3802,-555.8627;Inherit;False;FLOAT3;0;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;320,-560;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;CwanShader/Rock_CCA;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;48;0;46;0
WireConnection;134;0;136;0
WireConnection;134;1;48;4
WireConnection;125;0;6;3
WireConnection;131;0;46;0
WireConnection;43;0;134;0
WireConnection;37;0;125;0
WireConnection;37;1;25;0
WireConnection;116;0;6;2
WireConnection;132;0;131;4
WireConnection;115;0;6;1
WireConnection;173;0;88;0
WireConnection;2;0;46;0
WireConnection;66;0;116;0
WireConnection;59;0;37;0
WireConnection;103;0;104;0
WireConnection;103;1;115;0
WireConnection;212;0;209;0
WireConnection;212;1;214;0
WireConnection;129;0;66;0
WireConnection;129;1;138;0
WireConnection;16;1;103;0
WireConnection;16;2;13;0
WireConnection;93;0;59;0
WireConnection;93;1;174;0
WireConnection;109;0;2;4
WireConnection;149;0;97;0
WireConnection;149;1;4;0
WireConnection;149;2;150;0
WireConnection;21;0;16;0
WireConnection;21;1;129;0
WireConnection;21;2;23;0
WireConnection;163;0;149;0
WireConnection;73;0;93;0
WireConnection;73;1;174;0
WireConnection;213;0;212;0
WireConnection;112;0;6;4
WireConnection;159;0;73;0
WireConnection;159;1;161;0
WireConnection;215;0;213;0
WireConnection;151;0;112;0
WireConnection;151;1;139;0
WireConnection;151;2;142;0
WireConnection;28;0;16;0
WireConnection;28;1;21;0
WireConnection;156;0;155;0
WireConnection;156;1;157;0
WireConnection;202;0;215;0
WireConnection;202;1;203;0
WireConnection;144;0;159;0
WireConnection;144;1;151;0
WireConnection;108;0;2;0
WireConnection;197;0;196;0
WireConnection;62;0;28;0
WireConnection;62;1;63;0
WireConnection;121;0;62;0
WireConnection;19;0;108;0
WireConnection;204;0;202;0
WireConnection;204;1;205;0
WireConnection;198;0;197;0
WireConnection;154;0;144;0
WireConnection;154;1;156;0
WireConnection;206;0;204;0
WireConnection;206;1;203;0
WireConnection;145;0;154;0
WireConnection;199;0;198;0
WireConnection;199;1;200;0
WireConnection;201;0;199;0
WireConnection;126;0;73;0
WireConnection;207;0;206;0
WireConnection;22;0;35;0
WireConnection;22;1;169;0
WireConnection;226;0;225;0
WireConnection;224;0;222;0
WireConnection;224;1;226;0
WireConnection;224;2;225;4
WireConnection;122;0;22;0
WireConnection;146;0;170;0
WireConnection;217;0;207;0
WireConnection;217;1;201;0
WireConnection;217;2;218;0
WireConnection;128;0;171;0
WireConnection;253;0;146;0
WireConnection;253;1;254;0
WireConnection;221;0;224;0
WireConnection;221;1;122;0
WireConnection;221;2;217;0
WireConnection;165;0;164;0
WireConnection;0;0;221;0
WireConnection;0;1;165;0
WireConnection;0;4;253;0
WireConnection;0;5;128;0
ASEEND*/
//CHKSM=FC58428F6B06D895822165B0479318658CECB345
package io.swagger.codegen.options;

import java.util.Map;

import com.google.common.collect.ImmutableMap;

import io.swagger.codegen.CodegenConstants;
import io.swagger.codegen.languages.CsharpUnityClientCodegen;

public class CsharpUnityClientOptionsProvider implements OptionsProvider {
	public static final String PACKAGE_NAME_VALUE = "swagger_client_csharp_unity";
	public static final String PACKAGE_VERSION_VALUE = "1.0.0-SNAPSHOT";
	public static final String CLIENT_PACKAGE_VALUE = "IO.Swagger.Client.Test";

	@Override
	public String getLanguage() {
		return "CsharpUnity";
	}

	@Override
	public Map<String, String> createOptions() {
		ImmutableMap.Builder<String, String> builder = new ImmutableMap.Builder<String, String>();
		return builder.put(CodegenConstants.PACKAGE_NAME, PACKAGE_NAME_VALUE)
				.put(CodegenConstants.PACKAGE_VERSION, PACKAGE_VERSION_VALUE)
				.put(CsharpUnityClientCodegen.CLIENT_PACKAGE, CLIENT_PACKAGE_VALUE).build();
	}

	@Override
	public boolean isServer() {
		return false;
	}
}

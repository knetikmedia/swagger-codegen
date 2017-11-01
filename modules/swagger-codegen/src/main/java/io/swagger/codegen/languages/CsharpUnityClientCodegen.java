package io.swagger.codegen.languages;

public class CsharpUnityClientCodegen extends CsharpDotNet2ClientCodegen {

	public CsharpUnityClientCodegen() {
		super();

		supportsInheritance = true;
	}

	@Override
	public String getName() {
		return "CsharpUnity";
	}

	@Override
	public String getHelp() {
		return "Generates a C# Unity client library.";
	}

}

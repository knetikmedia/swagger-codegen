package io.swagger.codegen.csharpunity;

import io.swagger.codegen.AbstractOptionsTest;
import io.swagger.codegen.CodegenConfig;
import io.swagger.codegen.languages.CsharpUnityClientCodegen;
import io.swagger.codegen.options.CsharpUnityClientOptionsProvider;
import mockit.Expectations;
import mockit.Tested;

public class CsharpUnityClientOptionsTest extends AbstractOptionsTest {

	@Tested
	private CsharpUnityClientCodegen clientCodegen;

	public CsharpUnityClientOptionsTest() {
		super(new CsharpUnityClientOptionsProvider());
	}

	@Override
	protected CodegenConfig getCodegenConfig() {
		return clientCodegen;
	}

	@SuppressWarnings("unused")
	@Override
	protected void setExpectations() {
		new Expectations(clientCodegen) {
			{
				clientCodegen.setPackageName(CsharpUnityClientOptionsProvider.PACKAGE_NAME_VALUE);
				times = 1;
				clientCodegen.setPackageVersion(CsharpUnityClientOptionsProvider.PACKAGE_VERSION_VALUE);
				times = 1;
				clientCodegen.setClientPackage(CsharpUnityClientOptionsProvider.CLIENT_PACKAGE_VALUE);
				times = 1;
			}
		};
	}
}

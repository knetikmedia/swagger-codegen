package io.swagger.codegen.languages;

import static com.google.common.base.Strings.isNullOrEmpty;

import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import com.google.common.collect.ArrayListMultimap;
import com.google.common.collect.Multimap;

import io.swagger.codegen.CliOption;
import io.swagger.codegen.CodegenConstants;
import io.swagger.codegen.CodegenModel;
import io.swagger.codegen.CodegenOperation;
import io.swagger.codegen.CodegenProperty;
import io.swagger.codegen.CodegenType;
import io.swagger.codegen.SupportingFile;
import io.swagger.codegen.utils.ModelUtils;
import io.swagger.models.Model;
import io.swagger.models.Operation;
import io.swagger.models.Response;
import io.swagger.models.Swagger;
import io.swagger.models.properties.ArrayProperty;
import io.swagger.models.properties.BaseIntegerProperty;
import io.swagger.models.properties.BooleanProperty;
import io.swagger.models.properties.DateProperty;
import io.swagger.models.properties.DateTimeProperty;
import io.swagger.models.properties.DecimalProperty;
import io.swagger.models.properties.DoubleProperty;
import io.swagger.models.properties.FileProperty;
import io.swagger.models.properties.FloatProperty;
import io.swagger.models.properties.IntegerProperty;
import io.swagger.models.properties.LongProperty;
import io.swagger.models.properties.MapProperty;
import io.swagger.models.properties.Property;
import io.swagger.models.properties.RefProperty;
import io.swagger.models.properties.StringProperty;

public class CppUnrealClientCodegen extends AbstractCppCodegen {

	public static final String DECLSPEC = "declspec";
	public static final String DEFAULT_INCLUDE = "defaultInclude";

	protected String packageVersion = "1.0.0";
	protected String declspec = "";
	protected String defaultInclude = "";

	private final Set<String> parentModels = new HashSet<>();
	private final Multimap<String, CodegenModel> childrenByParent = ArrayListMultimap.create();

	/**
	 * Configures the type of generator.
	 * 
	 * @return the CodegenType for this generator
	 * @see io.swagger.codegen.CodegenType
	 */
	@Override
	public CodegenType getTag() {
		return CodegenType.CLIENT;
	}

	/**
	 * Configures a friendly name for the generator. This will be used by the
	 * generator to select the library with the -l flag.
	 * 
	 * @return the friendly name for the generator
	 */
	@Override
	public String getName() {
		return "cppunreal";
	}

	/**
	 * Returns human-friendly help for the generator. Provide the consumer with
	 * help tips, parameters here
	 * 
	 * @return A string value for the help message
	 */
	@Override
	public String getHelp() {
		return "Generates a C++ API client for use in Unreal Engine.";
	}

	public CppUnrealClientCodegen() {
		super();

		apiPackage = "io.swagger.client.api";
		modelPackage = "io.swagger.client.model";

		modelTemplateFiles.put("model-header.mustache", ".h");
		modelTemplateFiles.put("model-source.mustache", ".cpp");

		apiTemplateFiles.put("api-header.mustache", ".h");
		apiTemplateFiles.put("api-source.mustache", ".cpp");

		embeddedTemplateDir = templateDir = "cppUnreal";

		cliOptions.clear();

		// CLI options
		addOption(CodegenConstants.MODEL_PACKAGE, "C++ namespace for models (convention: name.space.model).",
				this.modelPackage);
		addOption(CodegenConstants.API_PACKAGE, "C++ namespace for apis (convention: name.space.api).",
				this.apiPackage);
		addOption(CodegenConstants.PACKAGE_VERSION, "C++ package version.", this.packageVersion);
		addOption(DECLSPEC, "C++ preprocessor to place before the class name for handling dllexport/dllimport.",
				this.declspec);
		addOption(DEFAULT_INCLUDE,
				"The default include statement that should be placed in all headers for including things like the declspec (convention: #include \"Commons.h\" ",
				this.defaultInclude);

		reservedWords = new HashSet<String>();
		reservedWords.add("template");

		supportingFiles.add(new SupportingFile("modelbase-header.mustache", "", "KnetikCloudModelBase.h"));
		supportingFiles.add(new SupportingFile("modelbase-source.mustache", "", "KnetikCloudModelBase.cpp"));
		supportingFiles.add(new SupportingFile("apiclient-header.mustache", "", "KnetikCloudApiClient.h"));
		supportingFiles.add(new SupportingFile("apiclient-source.mustache", "", "KnetikCloudApiClient.cpp"));
		supportingFiles
				.add(new SupportingFile("apiconfiguration-header.mustache", "", "KnetikCloudApiConfiguration.h"));
		supportingFiles
				.add(new SupportingFile("apiconfiguration-source.mustache", "", "KnetikCloudApiConfiguration.cpp"));
		supportingFiles.add(new SupportingFile("apiexception-header.mustache", "", "KnetikCloudApiException.h"));
		supportingFiles.add(new SupportingFile("apiexception-source.mustache", "", "KnetikCloudApiException.cpp"));
		supportingFiles.add(new SupportingFile("ihttpbody-header.mustache", "", "KnetikCloudIHttpBody.h"));
		supportingFiles.add(new SupportingFile("jsonbody-header.mustache", "", "KnetikCloudJsonBody.h"));
		supportingFiles.add(new SupportingFile("jsonbody-source.mustache", "", "KnetikCloudJsonBody.cpp"));
		supportingFiles.add(new SupportingFile("httpcontent-header.mustache", "", "KnetikCloudHttpContent.h"));
		supportingFiles.add(new SupportingFile("httpcontent-source.mustache", "", "KnetikCloudHttpContent.cpp"));
		supportingFiles.add(new SupportingFile("multipart-header.mustache", "", "KnetikCloudMultipartFormData.h"));
		supportingFiles.add(new SupportingFile("multipart-source.mustache", "", "KnetikCloudMultipartFormData.cpp"));
		// supportingFiles.add(new SupportingFile("gitignore.mustache", "",
		// ".gitignore"));
		// supportingFiles.add(new SupportingFile("git_push.sh.mustache", "",
		// "git_push.sh"));
		// supportingFiles.add(new SupportingFile("cmake-lists.mustache", "",
		// "CMakeLists.txt"));

		languageSpecificPrimitives = new HashSet<String>(
				Arrays.asList("int", "char", "bool", "long", "float", "int32"));

		typeMapping = new HashMap<String, String>();
		typeMapping.put("date", "utility::datetime");
		typeMapping.put("DateTime", "utility::datetime");
		typeMapping.put("string", "FString");
		typeMapping.put("integer", "int32");
		typeMapping.put("long", "int32");
		typeMapping.put("boolean", "bool");
		typeMapping.put("array", "TArray");
		typeMapping.put("map", "TMap");
		typeMapping.put("file", "HttpContent");
		typeMapping.put("object", "KnetikCloudObject");
		typeMapping.put("binary", "std::string");
		typeMapping.put("number", "float");
		typeMapping.put("double", "float");
		typeMapping.put("UUID", "FString");

		super.importMapping = new HashMap<String, String>();
		importMapping.put("FString", "");
		importMapping.put("HttpContent", "#include \"HttpContent.h\"");
		importMapping.put("KnetikCloudObject", "#include \"KnetikCloudObject.h\"");
		importMapping.put("TArray", "");
		importMapping.put("TMap", "");
	}

	protected void addOption(String key, String description, String defaultValue) {
		CliOption option = new CliOption(key, description);
		if (defaultValue != null) {
			option.defaultValue(defaultValue);
		}
		cliOptions.add(option);
	}

	@Override
	public void processOpts() {
		super.processOpts();

		if (additionalProperties.containsKey(DECLSPEC)) {
			declspec = additionalProperties.get(DECLSPEC).toString();
		}

		if (additionalProperties.containsKey(DEFAULT_INCLUDE)) {
			defaultInclude = additionalProperties.get(DEFAULT_INCLUDE).toString();
		}

		additionalProperties.put("modelNamespaceDeclarations", modelPackage.split("\\."));
		additionalProperties.put("modelNamespace", modelPackage.replaceAll("\\.", "::"));
		additionalProperties.put("apiNamespaceDeclarations", apiPackage.split("\\."));
		additionalProperties.put("apiNamespace", apiPackage.replaceAll("\\.", "::"));
		additionalProperties.put("declspec", declspec);
		additionalProperties.put("defaultInclude", defaultInclude);
	}

	/**
	 * Escapes a reserved word as defined in the `reservedWords` array. Handle
	 * escaping those terms here. This logic is only called if a variable
	 * matches the reseved words
	 * 
	 * @return the escaped term
	 */
	@Override
	public String escapeReservedWord(String name) {
		return "_" + name; // add an underscore to the name
	}

	/**
	 * Location to write model files. You can use the modelPackage() as defined
	 * when the class is instantiated
	 */
	@Override
	public String modelFileFolder() {
		return outputFolder + "/model";
	}

	/**
	 * Location to write api files. You can use the apiPackage() as defined when
	 * the class is instantiated
	 */
	@Override
	public String apiFileFolder() {
		return outputFolder + "/api";
	}

	@Override
	public String toModelImport(String name) {
		if (importMapping.containsKey(name))
			return importMapping.get(name);
		else {
			if (name.startsWith("UKnetikCloud")) {
				name = name.substring(1);
			}
			return "#include \"model/" + name + ".h\"";
		}
	}

	@Override
	public CodegenModel fromModel(String name, Model model, Map<String, Model> allDefinitions) {
		CodegenModel codegenModel = super.fromModel(name, model, allDefinitions);

		Set<String> oldImports = codegenModel.imports;
		codegenModel.imports = new HashSet<String>();
		for (String imp : oldImports) {
			if (imp.equals("UKnetikCloud" + name)) {
				continue;
			}
			String newImp = toModelImport(imp);
			if (!newImp.isEmpty()) {
				codegenModel.imports.add(newImp);
			}
		}

		return codegenModel;
	}

	@Override
	public CodegenOperation fromOperation(String path, String httpMethod, Operation operation,
			Map<String, Model> definitions, Swagger swagger) {
		CodegenOperation op = super.fromOperation(path, httpMethod, operation, definitions, swagger);

		if (operation.getResponses() != null && !operation.getResponses().isEmpty()) {
			Response methodResponse = findMethodResponse(operation.getResponses());

			if (methodResponse != null) {
				if (methodResponse.getSchema() != null) {
					CodegenProperty cm = fromProperty("response", methodResponse.getSchema());
					op.vendorExtensions.put("x-codegen-response", cm);
					if (cm.datatype == "HttpContent") {
						op.vendorExtensions.put("x-codegen-response-ishttpcontent", true);
					}
				}
			}
		}

		return op;
	}

	@Override
	public void postProcessModelProperty(CodegenModel model, CodegenProperty property) {
		if (isFileProperty(property)) {
			property.vendorExtensions.put("x-codegen-file", true);
		}

		if (!isNullOrEmpty(model.parent)) {
			String parent = model.parent;
			if (parent.startsWith("UKnetikCloud")) {
				parent = parent.substring(12);
			}
			parentModels.add(parent);
			if (!childrenByParent.containsEntry(parent, model)) {
				childrenByParent.put(parent, model);
			}
		}
	}

	protected boolean isFileProperty(CodegenProperty property) {
		return property.baseType.equals("HttpContent");
	}

	@Override
	public String toModelFilename(String name) {
		return "KnetikCloud" + escapeGenerics(initialCaps(name));
	}

	@Override
	public String toApiFilename(String name) {
		return "KnetikCloud" + escapeGenerics(initialCaps(name) + "Api");
	}

	/**
	 * Optional - type declaration. This is a String which is used by the
	 * templates to instantiate your types. There is typically special handling
	 * for different property types
	 *
	 * @return a string value used as the `dataType` field for model templates,
	 *         `returnType` for api templates
	 */
	@Override
	public String getTypeDeclaration(Property p) {
		String swaggerType = getSwaggerType(p);

		if (p instanceof ArrayProperty) {
			ArrayProperty ap = (ArrayProperty) p;
			Property inner = ap.getItems();
			return getSwaggerType(p) + "<" + getTypeDeclaration(inner) + ">";
		}
		if (p instanceof MapProperty) {
			MapProperty mp = (MapProperty) p;
			Property inner = mp.getAdditionalProperties();
			return getSwaggerType(p) + "<FString, " + getTypeDeclaration(inner) + ">";
		}
		if (p instanceof StringProperty || p instanceof DateProperty || p instanceof DateTimeProperty
				|| p instanceof FileProperty || languageSpecificPrimitives.contains(swaggerType))
			return toModelName(swaggerType);

		return swaggerType;
	}

	@Override
	public String toDefaultValue(Property p) {
		if (p instanceof StringProperty)
			return "TEXT(\"\")";
		else if (p instanceof BooleanProperty)
			return "false";
		else if (p instanceof DateProperty)
			return "utility::datetime()";
		else if (p instanceof DateTimeProperty)
			return "utility::datetime()";
		else if (p instanceof DoubleProperty)
			return "0.0";
		else if (p instanceof FloatProperty)
			return "0.0f";
		else if (p instanceof LongProperty)
			return "0L";
		else if (p instanceof IntegerProperty || p instanceof BaseIntegerProperty)
			return "0";
		else if (p instanceof DecimalProperty)
			return "0.0";
		else if (p instanceof MapProperty) {
			MapProperty ap = (MapProperty) p;
			String inner = getSwaggerType(ap.getAdditionalProperties());
			return "TMap()";
		} else if (p instanceof ArrayProperty) {
			ArrayProperty ap = (ArrayProperty) p;
			String inner = getSwaggerType(ap.getItems());
			return "TArray<" + inner + ">()";
		} else if (p instanceof RefProperty) {
			RefProperty rp = (RefProperty) p;
			return "new " + toModelName(rp.getSimpleRef()) + "()";
		}
		return "nullptr";
	}

	/**
	 * Optional - swagger type conversion. This is used to map swagger types in
	 * a `Property` into either language specific types via `typeMapping` or
	 * into complex models if there is not a mapping.
	 *
	 * @return a string value of the type or complex model for this property
	 * @see io.swagger.models.properties.Property
	 */
	@Override
	public String getSwaggerType(Property p) {
		String swaggerType = super.getSwaggerType(p);
		String type = null;
		if (typeMapping.containsKey(swaggerType)) {
			type = typeMapping.get(swaggerType);
			if (languageSpecificPrimitives.contains(type))
				return toModelName(type);
		} else {
			type = swaggerType;
		}
		return toModelName(type);
	}

	@Override
	public String toModelName(String type) {
		if (typeMapping.keySet().contains(type) || typeMapping.values().contains(type)
				|| importMapping.values().contains(type) || defaultIncludes.contains(type)
				|| languageSpecificPrimitives.contains(type))
			return type;
		else
			return "UKnetikCloud" + escapeGenerics(Character.toUpperCase(type.charAt(0)) + type.substring(1));
	}

	@Override
	public String toApiName(String type) {
		return "UKnetikCloud" + escapeGenerics(Character.toUpperCase(type.charAt(0)) + type.substring(1) + "Api");
	}

	private String escapeGenerics(String string) {
		int idx = string.indexOf('«');
		while (idx > 0) {
			string = string.substring(0, idx) + Character.toUpperCase(string.charAt(idx + 1))
					+ string.substring(idx + 2);
			idx = string.indexOf('«');
		}
		idx = string.indexOf(',');
		while (idx > 0) {
			string = string.substring(0, idx) + Character.toUpperCase(string.charAt(idx + 1))
					+ string.substring(idx + 2);
			idx = string.indexOf(',');
		}
		return string.replace("»", "");
	}

	@Override
	public String escapeQuotationMark(String input) {
		// remove " to avoid code injection
		return input.replace("\"", "");
	}

	@Override
	public String escapeUnsafeCharacters(String input) {
		return input.replace("*/", "*_/").replace("/*", "/_*");
	}

	@Override
	public Map<String, Object> postProcessAllModels(final Map<String, Object> models) {

		final Map<String, Object> processed = super.postProcessAllModels(models);
		postProcessParentModels(models);
		return processed;
	}

	private void postProcessParentModels(final Map<String, Object> models) {
		for (final String parent : parentModels) {
			String parentSub = parent;
			if (parentSub.startsWith("UKnetikCloud")) {
				parentSub = parentSub.substring(12);
			}
			final CodegenModel parentModel = ModelUtils.getModelByName(parentSub, models);
			final Collection<CodegenModel> childrenModels = childrenByParent.get(parent);
			for (final CodegenModel child : childrenModels) {
				processParentPropertiesInChildModel(parentModel, child);
			}
		}
	}

	/**
	 * Sets the child property's isInherited flag to true if it is an inherited
	 * property
	 */
	private void processParentPropertiesInChildModel(final CodegenModel parent, final CodegenModel child) {
		final Map<String, CodegenProperty> childPropertiesByName = new HashMap<>(child.vars.size());
		for (final CodegenProperty childProperty : child.vars) {
			childPropertiesByName.put(childProperty.name, childProperty);
		}
		for (final CodegenProperty parentProperty : parent.vars) {
			final CodegenProperty duplicatedByParent = childPropertiesByName.get(parentProperty.name);
			if (duplicatedByParent != null) {
				duplicatedByParent.isInherited = true;
			}
		}
	}

}

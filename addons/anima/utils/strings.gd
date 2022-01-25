class_name AnimaStrings

static func from_camel_to_snack_case(string:String) -> String:
	var results = Array()
	var is_first_char = true

	for character in string:
		if character == character.to_lower() or is_first_char:
			results.append(character.to_lower())
		else:
			results.append('_' + character.to_lower())

		is_first_char = false

	return "".join(results).replace(' ', '_')


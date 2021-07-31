#macro DerpXmlType_StartOfFile "StartOfFile"
#macro DerpXmlType_OpenTag "OpenTag"
#macro DerpXmlType_CloseTag "CloseTag"
#macro DerpXmlType_Text "Text"
#macro DerpXmlType_Whitespace "Whitespace"
#macro DerpXmlType_EndOfFile "EndOfFile"
#macro DerpXmlType_Comment "Comment"

/// @description  DerpXml_Init()
function DerpXml_Init() {
	//
	//  Initializes DerpXml. Call this once at the start of your game.

	if not instance_exists(objDerpXmlRead) {
	    with instance_create_depth(0, 0, 0, objDerpXmlRead) {
	        readMode_String = 0
	        readMode_File = 1
	        attributeMap = ds_map_create()
        
	        readMode = readMode_String
	        xmlString = ""
	        xmlFile = -1
        
	        stringPos = 0
	        currentType = DerpXmlType_StartOfFile
	        currentValue = ""
	        currentRawValue = ""
	        lastReadEmptyElement = false
	        lastNonCommentType = DerpXmlType_StartOfFile
	    }
	}

	if not instance_exists(objDerpXmlWrite) {
	    with instance_create_depth(0, 0, 0, objDerpXmlWrite) {
	        indentString = "  "
	        newlineString = chr(10)
	        tagNameStack = ds_stack_create()
        
	        writeString = ""
	        currentIndent = 0
	        lastWriteType = DerpXmlType_StartOfFile
	        lastWriteEmptyElement = false
	    }
	}



}

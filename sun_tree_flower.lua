-- theaccessibleproject.lua

-- A function to gather information
-- about accessibility features
function getAccessibleInfo() 
	local accessibleInfo = {}; 
	
	-- Look for AccessKeys in HTML
	local accessKeys = {}; 
	
	-- Do a regular expression search
	local accessKeyPattern = "accesskey="; 
	for i, v in ipairs(document.getElementsByTagName("*")) do 
		if (string.find(v.outerHTML, accessKeyPattern)) then
			table.insert(accessKeys, string.sub(v.outerHTML, string.find(v.outerHTML, accessKeyPattern) + 11)); 
		end
	end
	
	-- Store the list of access keys
	accessibleInfo["accessKeys"] = accessKeys; 
	
	-- Determine if the page has form elements
	accessibleInfo["hasForms"] = false; 
	if (#document.getElementsByTagName("form") > 0) then
		accessibleInfo["hasForms"] = true; 
	end
	
	-- Look for JavaScript event handlers
	local jsEvents = {}; 
	
	-- Do a regular expression search
	local jsEventPattern = "on%w+=";
	for i, v in ipairs(document.getElementsByTagName("*")) do 
		if (string.find(v.outerHTML, jsEventPattern)) then
			table.insert(jsEvents, string.sub(v.outerHTML, string.find(v.outerHTML, jsEventPattern) + 6)); 
		end
	end
	
	-- Store the list of JavaScript event handlers
	accessibleInfo["jsEvents"] = jsEvents; 
	
	-- Determine the presence of an ARIA application
	accessibleInfo["hasAriaApp"] = false; 
	
	-- Look for ARIA role attributes
	for i, v in ipairs(document.getElementsByTagName("*")) do 
		if (v.getAttribute("role")) then 
			accessibleInfo["hasAriaApp"] = true; 
			break; 
		end
	end
	
	-- Look for listenable audio content
	accessibleInfo["hasAudio"] = false;
	for i, v in ipairs(document.getElementsByTagName("audio")) do
		if (v.readyState > 0) then
			accessibleInfo["hasAudio"] = true; 
			break;
		end
	end
	
	-- Look for viewable video content
	accessibleInfo["hasVideo"] = false;
	for i, v in ipairs(document.getElementsByTagName("video")) do
		if (v.readyState > 0) then
			accessibleInfo["hasVideo"] = true; 
			break;
		end
	end
	
	-- Returns the information about the accessible elements found
	return accessibleInfo;
end

-- A function to output an accessibility report based on
-- the gathered information
function exportAccessibilityReport(accessibleInfo)
	local report = "";

	-- Output the list of access keys
	report = report .. "Access Keys: ";
	for i, v in ipairs(accessibleInfo["accessKeys"]) do
		report = report .. v .. " ";
	end

	-- Add a new line
	report = report .. "\n";
	
	-- Output whether the page has forms
	if (accessibleInfo["hasForms"] == true) then
		report = report .. "The page has forms.\n";
	else
		report = report .. "The page does not have forms.\n";
	end

	-- Output the list of JavaScript events
	report = report .. "JavaScript events: ";
	for i, v in ipairs(accessibleInfo["jsEvents"]) do
		report = report .. v .. " ";
	end
	
	-- Add a new line
	report = report .. "\n";
	
	-- Output whether the page has an ARIA application
	if (accessibleInfo["hasAriaApp"] == true) then
		report = report .. "The page has an ARIA application.\n";
	else
		report = report .. "The page does not have an ARIA application.\n";
	end

	-- Output whether the page has listenable audio content
	if (accessibleInfo["hasAudio"] == true) then
		report = report .. "The page has listenable audio content.\n";
	else
		report = report .. "The page does not have listenable audio content.\n";
	end

	-- Output whether the page has viewable video content
	if (accessibleInfo["hasVideo"] == true) then
		report = report .. "The page has viewable video content.\n";
	else
		report = report .. "The page does not have viewable video content.\n";
	end
	
	-- Return the completed report
	return report;
end

-- Main function
function main() 
	-- Gather accessibility information
	local accessibleInfo = getAccessibleInfo(); 
	
	-- Output the accessibility report
	print(exportAccessibilityReport(accessibleInfo)); 
end

main()
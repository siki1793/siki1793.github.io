require("lualibs.lua")

function getJsonFromFile(file)
  local fileHandle = io.open(file)
  local jsonString = fileHandle:read('*a')
  fileHandle.close()
  local jsonData = utilities.json.tolua(jsonString)
  return jsonData
end

function printEduItems(file)
  local json = getJsonFromFile(file)
  for key, value in pairs(json) do
    tex.print("\\resumeEduEntry")
    tex.print("{" .. value["school"] .. "}")
    tex.print("{" .. value["school_location"] .. "}")
    tex.print("{" .. value["degree"] .. "}")
    tex.print("{" .. value["time_period"] .. "}")
  end
end

function printExpItems(file)
  local json = getJsonFromFile(file)
  for key, value in pairs(json) do
    tex.print("\\resumeExpEntry")
    tex.print("{" .. value["company"] .. "}")
    tex.print("{" .. value["company_location"] .. "}")
    tex.print("{" .. value["role"] .. "}")
    tex.print("{" .. value["team"] .. "}")
    tex.print("{" .. value["time_duration"] .. "}")

    tex.print("\\resumeItemListStart")
    for key, value in pairs(value["details"]) do
      tex.print("\\resumeItem")
      tex.print("{" .. value["title"] .. "}")
      tex.print("{" .. value["languages"] .. "}")
      tex.print("\\resumeSubItemListStart")
      for key, value in pairs(value["description"]) do
        tex.print("\\item\\small")
        tex.print(value["point"])
      end
      tex.print("\\resumeSubItemListEnd")
      
    end
    tex.print("\\resumeItemListEnd")
  end
end

function printProjItems(file)
  local json = getJsonFromFile(file)
  for key, value in pairs(json) do
    tex.print("\\resumeItem")
    tex.print("{" .. value["title"] .. "}")
    tex.print("{" .. value["languages"] .. "}")
    tex.print("\\\\")
    for key, value in pairs(value["description"]) do
      tex.print("\\vspace{-2pt}")
      tex.print("\\small\\item[$\\textbullet$]")
      tex.print(value["point"])
    end
    tex.print("\\\\")
    tex.print("\\vspace{5pt}")
    for key, value in pairs(value["links"]) do
      if(string.len(value["name"])==0)
      then
      else
        tex.print("\\small\\textbf{Project Link :}")
        tex.print("\\href")
        tex.print("{"..value["repo"].."/}")
        tex.print("{"..value["name"].."}\\hspace{20mm}")
      end
    end
    -- tex.print("\\resumeSubItemListEnd") 
  end
  -- tex.print("\\resumeItemListEnd")
end

function printHeading(file)
  local json = getJsonFromFile(file)
  for key, value in pairs(json) do
    tex.print("\\begin{tabular*}{\\textwidth}{l@{\\extracolsep{\\fill}}r}")
    tex.print("\\textbf{\\href")
    tex.print("{https:" .. value["website"] .. "/}")
    tex.print("{\\Large " .. value["name"] .. "}}")
    tex.print(" & \\faGlobe: \\href")
    tex.print("{https://" .. value["website"] .. "/}")
    tex.print("{" .. value["website"] .. "}\\\\")
    tex.print("\\end{tabular*}")

    tex.print("\\begin{tabular*}{\\linewidth}{@{}@{\\extracolsep{\\fill}}lcr@{}}")

    tex.print("\\faAt: \\href")
    tex.print("{mailto:" .. value["email"] .. "}")
    tex.print("{" .. value["email"] .. "}")
    tex.print(" & \\faPhone: " .. value["phone"] .. "")
    tex.print(" & \\faGithub: \\href")
    tex.print("{https://" .. value["github"] .. "/}")
    tex.print("{" .. value["github"] .. "}\\\\")

    tex.print("\\end{tabular*}")
  end
end

function printList(file, primary, secondary)
  local json = getJsonFromFile(file)
  local first = true
  for key, value in pairs(json) do
    for key, value in pairs(value[primary]) do
      if (first) then
        tex.print(value[secondary])
        first = false
      else
        tex.print(", " .. value[secondary])
      end
    end
  end
end

function printObjItems(file)
  local json = getJsonFromFile(file)
  for key, value in pairs(json) do
    tex.print("\\small")
    tex.print(value["objective"])
  end
end

function printAchItems(file)
  local json = getJsonFromFile(file)
  for key, value in pairs(json) do
    tex.print("\\small\\item[$\\bullet$]")
    tex.print(value["point"])
    tex.print("\\vspace{-5pt}")
  end
end

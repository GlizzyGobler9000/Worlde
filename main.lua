local WordData = require("WordData")

local WhiteList = {} -- green and yellow letters go here
local BlackList = {} -- grey letters go here

local Alphabet = WordData.Alphabet
local WordList = WordData.WordList

local Word = ""

local SolutionList = {}
local WordCount = 0

local function CheckWordList(word) -- check if word is in word list
  local yeah = false
  for i = 1, #WordList do
    if word == WordList[i] then
      yeah = true
      break
    end
  end
  return yeah
end

local function CheckNotBlackList(word) -- check for blacklisted letters in word
  local yeah = true
  for i = 1, #BlackList do
    if string.find(word, BlackList[i]) then
      yeah = false
      break
    end
  end
  return yeah
end

local function CheckWhiteList(word) -- check for whitelisted letters in word
  local yeah = false
  local count = 0
  for i = 1, #WhiteList do
    if string.find(word, WhiteList[i]) then
      count = count + 1 -- this method makes sure that the word has ALL whitelisted words
    end
  end
  if count >= #WhiteList then
    yeah = true
  end
  return yeah
end


local UserInput = ""
print("Yellow/Green Letters: ")
UserInput = io.read() -- get whitelisted letters
for i = 1, string.len(UserInput) do
  table.insert(WhiteList, string.sub(UserInput, i, i))
end
UserInput = ""
print("Gray Letters: ")
UserInput = io.read() -- get blacklisted letters
for i = 1, string.len(UserInput) do
  table.insert(BlackList, string.sub(UserInput, i, i))
end

print()
print("Possible Words:")


for Letter1 = 1, #Alphabet do -- construct word
  for Letter2 = 1, #Alphabet do
    for Letter3 = 1, #Alphabet do
      for Letter4 = 1, #Alphabet do
        for Letter5 = 1, #Alphabet do
          Word = Alphabet[Letter1] .. Alphabet[Letter2] .. Alphabet[Letter3] .. Alphabet[Letter4] .. Alphabet[Letter5] -- glue word together

          if CheckNotBlackList(Word) then -- testing
            if CheckWhiteList(Word) then
              if CheckWordList(Word) then -- last check for optimization
                WordCount = WordCount + 1
                print(WordCount..". "..Word)
                table.insert(SolutionList, Word)
                Word = ""
              end
            end
          end
        end
      end
    end
  end
end

print("Program End") -- just in case you didn't know
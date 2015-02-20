import os

echo "Welcome to brainfuck"

let code = if paramCount() > 0: readFile paramStr(1)
           else: readAll stdin

echo code

var
  tape = newSeq[char]()
  codePos = 0
  tapePos = 0

# proc run(skip = false): bool =
#   echo "codePos: ", codePos, " tapePos: ", tapePos



proc run(skip = false): bool =
  while tapePos >= 0 and codePos < code.len:
    if tapePos >= tape.len:
      tape.add '\0'
    if code[codePos] == '[':
      inc codePos
      let oldPos = codePos
      while run(tape[tapePos] == '\0'):
        codePos = oldPos
    elif code[codePos] == ']':
      return tape[tapePos] != '\0'
    case code[codePos]
    of '+': inc tape[tapePos]
    of '-': dec tape[tapePos]
    of '>': inc tapePos
    of '<': dec tapePos
    of '.': stdout.write tape[tapePos]
    of ',': tape[tapePos] = stdin.readChar
    else: discard

    inc codePos

discard run()

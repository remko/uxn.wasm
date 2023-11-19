////////////////////////////////////////////////////////////////////////////////
// Uxntal assembler
////////////////////////////////////////////////////////////////////////////////

export const LIT = 0x80,
  LIT2 = 0xa0,
  JMI = 0x40,
  JSI = 0x60,
  JCI = 0x20;

const opcodes = [
  "LIT",
  "INC",
  "POP",
  "NIP",
  "SWP",
  "ROT",
  "DUP",
  "OVR",
  "EQU",
  "NEQ",
  "GTH",
  "LTH",
  "JMP",
  "JCN",
  "JSR",
  "STH",
  "LDZ",
  "STZ",
  "LDR",
  "STR",
  "LDA",
  "STA",
  "DEI",
  "DEO",
  "ADD",
  "SUB",
  "MUL",
  "DIV",
  "AND",
  "ORA",
  "EOR",
  "SFT",
];

function opcode(s) {
  if (s === "BRK") {
    return 0;
  }
  for (let i = 0; i < 0x20; i++) {
    if (s.slice(0, 3) != opcodes[i]) {
      continue;
    }
    let m = 0;
    if (!i) {
      i |= 1 << 7; /* force keep for LIT */
    }
    while (s[3 + m]) {
      if (s[3 + m] == "2") {
        i |= 1 << 5; /* mode: short */
      } else if (s[3 + m] == "r") {
        i |= 1 << 6;
      } /* mode: return */ else if (s[3 + m] == "k") {
        i |= 1 << 7;
      } /* mode: keep */ else {
        return -1;
      } /* failed to match */
      m++;
    }
    return i;
  }
  return -1;
}

function isNumber(c) {
  return /^([0-9A-Fa-f]{4}|[0-9A-Fa-f]{2})$/.test(c);
}

function isWhitespace(c) {
  return /\s/.test(c);
}

function assertValidName(l) {
  if (isNumber(l)) {
    throw new Error(`label is a number: ${l}`);
  }
  return l;
}

function expandLabel(label, currentLabel) {
  if (label.startsWith("&")) {
    return currentLabel + "/" + assertValidName(label.slice(1));
  }
  return assertValidName(label);
}

export default function asm(
  source,
  options = {
    include: () => {
      throw new Error("include not supported");
    },
  }
) {
  ////////////////////////////////////////////////////////////////////////////////
  // Tokenizer
  ////////////////////////////////////////////////////////////////////////////////

  let sp = 0;

  function skipComments() {
    let d = 1;
    while (d > 0 && sp < source.length) {
      const c = source[sp++];
      if (c === ")") {
        d -= 1;
      } else if (c === "(") {
        d += 1;
      }
    }
  }

  function readToken() {
    if (sp >= source.length) {
      return null;
    }
    let token = "";
    while (sp < source.length) {
      const c = source[sp++];
      if (c === "(") {
        skipComments();
      } else if (isWhitespace(c) && token.length === 0) {
        continue;
      } else if (isWhitespace(c)) {
        return token;
      } else {
        token += c;
      }
    }
    return token.length > 0 ? token : null;
  }

  ////////////////////////////////////////////////////////////////////////////////

  let cp = 0x100;
  const code = [];

  function emit(...cs) {
    if (cp < 0x100) {
      throw Error("unexpected emit");
    }
    for (const c of cs) {
      code[cp - 0x100] = c & 0xff;
      cp += 1;
    }
  }

  function emit2(...cs) {
    if (cp < 0x100) {
      throw Error("unexpected emit");
    }
    for (const c of cs) {
      code[cp - 0x100] = c >> 8;
      code[cp - 0x100 + 1] = c & 0xff;
      cp += 2;
    }
  }

  ////////////////////////////////////////////////////////////////////////////////

  const lambdas = [];
  const macros = {};
  const labels = {};
  const refs = [];
  let currentLabel = "on-reset";

  for (let token = readToken(); token != null; token = readToken()) {
    const c0 = token[0];
    const rtoken = token.substr(1);
    if (token === "[" || token === "]") {
      continue;
    } else if (token === "{") {
      emit(JSI, 0x00, 0x00);
      lambdas.push(cp - 2);
    } else if (token === "?{") {
      emit(JCI, 0x00, 0x00);
      lambdas.push(cp - 2);
    } else if (token === "}") {
      if (lambdas.length <= 0) {
        throw new Error("unexpected lambda end");
      }
      const l = lambdas.pop();
      const ocp = cp;
      cp = l;
      emit2(ocp - cp - 2);
      cp = ocp;
    } else if (c0 === "%") {
      let body = [];
      while (token != null) {
        token = readToken();
        if (token === "{") {
          continue;
        } else if (token === "}") {
          break;
        } else {
          body.push(token);
        }
      }
      macros[assertValidName(rtoken)] = body.join(" ");
    } else if (c0 === "~") {
      source = options.include(rtoken) + "\n" + source.substr(sp);
      sp = 0;
    } else if (c0 === "#") {
      if (token.length === 3) {
        emit(LIT, parseInt(rtoken, 16));
      } else if (token.length === 5) {
        emit(LIT2);
        emit2(parseInt(rtoken, 16));
      } else {
        throw Error(`unexpected literal length: ${token}`);
      }
    } else if (c0 === "|") {
      cp = parseInt(rtoken, 16);
    } else if (c0 === "$") {
      cp += parseInt(rtoken, 16);
    } else if (c0 === "@") {
      labels[assertValidName(rtoken)] = cp;
      currentLabel = rtoken;
    } else if (c0 === "&") {
      labels[expandLabel(token, currentLabel)] = cp;
    } else if (c0 === "," || c0 === ".") {
      emit(LIT, 0x00);
      refs.push({
        type: c0,
        label: expandLabel(rtoken, currentLabel),
        offset: cp - 1,
      });
    } else if (c0 === ";") {
      emit(LIT2, 0x00, 0x00);
      refs.push({
        type: c0,
        label: expandLabel(rtoken, currentLabel),
        offset: cp - 2,
      });
    } else if (c0 === "_" || c0 === "-") {
      emit(0x00);
      refs.push({
        type: c0,
        label: expandLabel(rtoken, currentLabel),
        offset: cp - 1,
      });
    } else if (c0 === "=") {
      emit(0x00, 0x00);
      refs.push({
        type: c0,
        label: expandLabel(rtoken, currentLabel),
        offset: cp - 2,
      });
    } else if (c0 === '"') {
      emit(...new TextEncoder().encode(rtoken));
    } else if (c0 === "!") {
      emit(JMI, 0x00, 0x00);
      refs.push({
        type: c0,
        label: expandLabel(rtoken, currentLabel),
        offset: cp - 2,
      });
    } else if (c0 === "?") {
      emit(JCI, 0x00, 0x00);
      refs.push({
        type: c0,
        label: expandLabel(rtoken, currentLabel),
        offset: cp - 2,
      });
    } else {
      const opc = opcode(token);
      if (opc >= 0) {
        emit(opc);
      } else if (macros[token] != null) {
        source = macros[token] + " " + source.slice(sp);
        sp = 0;
      } else if (isNumber(token)) {
        (token.length === 2 ? emit : emit2)(parseInt(token, 16));
      } else {
        emit(JSI, 0x00, 0x00);
        refs.push({
          type: "",
          label: expandLabel(token, currentLabel),
          offset: cp - 2,
        });
      }
    }
  }

  for (const { type, label, offset } of refs) {
    const l = labels[label];
    if (l == null) {
      throw new Error(`unknown reference: ${label}`);
    }
    cp = offset;
    switch (type) {
      case ",":
      case "_": {
        const d = l - offset - 2;
        emit(d >= 0 ? d : 0x100 + d);
        break;
      }
      case "":
      case "!":
      case "?": {
        const d = l - offset - 2;
        emit2(d >= 0 ? d : 0x10000 + d);
        break;
      }
      case ".":
      case "-":
        emit(l);
        break;
      case ";":
      case "=":
        emit2(l);
        break;
      default:
        throw new Error("unexpected error");
    }
  }

  for (let i = 0; i < code.length; i++) {
    code[i] = code[i] || 0;
  }
  return new Uint8Array(code);
}

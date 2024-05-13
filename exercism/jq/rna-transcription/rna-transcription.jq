def transcribe: {G:"C",C:"G",T:"A",A:"U"}[.];
def toRna: split("") | map(transcribe) | join("");

BEGIN { FS = "" }
{ for (i = NF; i > 0; i--) printf "%s", $i }

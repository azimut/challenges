!isTriangle($1,$2,$3) { print "false"; next }

type == "equilateral" { print $1~$2 && $2~$3 ? "true" : "false" }
type == "isosceles"   { print $1~$2 || $2~$3 || $1~$3 ? "true" : "false" }
type == "scalene"     { print $1!=$2 && $2!=$3 && $1!=$3 ? "true" : "false" }

function isTriangle(    a,b,c) { return a+b+c && a+b>=c && b+c>=a && a+c>=b }

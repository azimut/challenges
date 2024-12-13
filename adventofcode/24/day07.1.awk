BEGIN { FPAT="[0-9]+" }
      { admul($1,$2,3) }
  END { print total }

function admul(    target,acc,idx) { # stolen solution
    if (acc == target && idx > NF) {
        total += target
        next
    }
    if (acc > target) return
    if (idx > NF) return
    admul(target, acc*$idx, idx+1)
    admul(target, acc+$idx, idx+1)
}

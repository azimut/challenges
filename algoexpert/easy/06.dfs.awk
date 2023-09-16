BEGIN {
    tree["a"] = "b,c,d"
    tree["b"] = "e,f"
    tree["d"] = "g,h"
    tree["f"] = "i,j"
    tree["g"] = "k"
    dfs("a")
}

function dfs(    parent, i, childs) {
    printf latch++ ? ",%s" : "%s", parent
    for (i = 1; i <= split(tree[parent], childs, /,/); i++)
        dfs(childs[i])
}
